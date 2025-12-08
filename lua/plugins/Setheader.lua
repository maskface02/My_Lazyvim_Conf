-- 42 Header Plugin for Neovim
local M = {}

-- ASCII art for 42 header
local ascii_art = {
    "        :::      ::::::::",
    "      :+:      :+:    :+:",
    "    +:+ +:+         +:+  ",
    "  +#+  +:+       +#+     ",
    "+#+#+#+#+#+   +#+        ",
    "     #+#    #+#          ",
    "    ###   ########.fr    "
}

-- Default settings
local start_comment = '/*'
local end_comment = '*/'
local fill_char = '*'
local header_length = 80
local margin_size = 5

-- File type mappings
local file_types = {
    ['.c$'] = {'/*', '*/', '*'},
    ['.h$'] = {'/*', '*/', '*'},
    ['.cc$'] = {'/*', '*/', '*'},
    ['.cpp$'] = {'/*', '*/', '*'},
    ['.hpp$'] = {'/*', '*/', '*'},
    ['.go$'] = {'/*', '*/', '*'},
    ['.rs$'] = {'/*', '*/', '*'},
    ['.php$'] = {'/*', '*/', '*'},
    ['.java$'] = {'/*', '*/', '*'},
    ['.kt$'] = {'/*', '*/', '*'},
    ['.kts$'] = {'/*', '*/', '*'},
    ['.htm$'] = {'<!--', '-->', '*'},
    ['.html$'] = {'<!--', '-->', '*'},
    ['.xml$'] = {'<!--', '-->', '*'},
    ['.js$'] = {'//', '//', '*'},
    ['.ts$'] = {'//', '//', '*'},
    ['.tex$'] = {'%', '%', '*'},
    ['.ml$'] = {'(*', '*)', '*'},
    ['.mli$'] = {'(*', '*)', '*'},
    ['.mll$'] = {'(*', '*)', '*'},
    ['.mly$'] = {'(*', '*)', '*'},
    ['.vim$'] = {'"', '"', '*'},
    ['vimrc$'] = {'"', '"', '*'},
    ['.el$'] = {';', ';', '*'},
    ['.emacs$'] = {';', ';', '*'},
    ['.asm$'] = {';', ';', '*'},
    ['.f90$'] = {'!', '!', '/'},
    ['.f95$'] = {'!', '!', '/'},
    ['.f03$'] = {'!', '!', '/'},
    ['.f$'] = {'!', '!', '/'},
    ['.for$'] = {'!', '!', '/'},
    ['.lua$'] = {'--', '--', '-'},
    ['.py$'] = {'#', '#', '*'},
    ['.sh$'] = {'#', '#', '*'},
}

-- Function to get current user
local function get_user()
    local user = os.getenv('USER') or 'marvin'
    return user
end

-- Function to get current email
local function get_email()
    local email = os.getenv('EMAIL') or 'marvin@42.fr'
    return email
end

-- Function to get current filename
local function get_filename()
    local filename = vim.fn.expand('%:t')
    if filename == '' then
        filename = '< new >'
    end
    return filename
end

-- Function to get current date
local function get_date()
    return os.date('%Y/%m/%d %H:%M:%S')
end

-- Function to determine file type and set appropriate comment style
local function set_file_type()
    local filename = vim.fn.expand('%:t')
    local extension = vim.fn.expand('%:e')
    
    if extension ~= '' then
        extension = '.' .. extension
    end
    
    for pattern, values in pairs(file_types) do
        if string.match(filename, pattern) or string.match(extension, pattern) then
            start_comment = values[1]
            end_comment = values[2]
            fill_char = values[3]
            break
        end
    end
end

-- Function to get ASCII art line
local function get_ascii_line(n)
    local index = n - 3
    if index >= 1 and index <= #ascii_art then
        return ascii_art[index]
    else
        return ''
    end
end

-- Function to create a text line for the header
local function create_text_line(left, right)
    local left_part = string.sub(left, 1, header_length - margin_size * 2 - string.len(right or ''))
    local right_part = right or ''
    
    local padding = header_length - margin_size * 2 - string.len(left_part) - string.len(right_part)
    if padding < 0 then
        padding = 0
    end
    
    local result = start_comment .. string.rep(' ', margin_size - string.len(start_comment)) .. left_part 
        .. string.rep(' ', padding) .. right_part 
        .. string.rep(' ', margin_size - string.len(end_comment)) .. end_comment
    
    return result
end

-- Function to create a line of the header
local function create_header_line(n)
    if n == 1 or n == 11 then  -- top and bottom line
        return start_comment .. ' ' .. string.rep(fill_char, header_length - string.len(start_comment) - string.len(end_comment) - 2) .. ' ' .. end_comment
    elseif n == 2 or n == 10 then  -- blank line
        return create_text_line('', '')
    elseif n == 3 or n == 5 or n == 7 then  -- empty with ascii
        return create_text_line('', get_ascii_line(n))
    elseif n == 4 then  -- filename
        return create_text_line(get_filename(), get_ascii_line(n))
    elseif n == 6 then  -- author
        return create_text_line('By: ' .. get_user() .. ' <' .. get_email() .. '>', get_ascii_line(n))
    elseif n == 8 then  -- created
        return create_text_line('Created: ' .. get_date() .. ' by ' .. get_user(), get_ascii_line(n))
    elseif n == 9 then  -- updated
        return create_text_line('Updated: ' .. get_date() .. ' by ' .. get_user(), get_ascii_line(n))
    end
end

-- Function to insert the header
local function insert_header()
    set_file_type()
    
    -- Create the header lines
    local header_lines = {}
    for n = 1, 11 do
        table.insert(header_lines, create_header_line(n))
    end
    
    -- Add an empty line after the header
    table.insert(header_lines, '')
    
    -- Insert the header at the beginning of the file
    vim.api.nvim_buf_set_lines(0, 0, 0, false, header_lines)
end

-- Function to update the header if it already exists
local function update_header()
    set_file_type()
    
    local lines = vim.api.nvim_buf_get_lines(0, 0, 11, false)
    if #lines >= 9 then
        local ninth_line = lines[9]  -- Lua tables are 1-indexed, so line 9 is at index 9
        
        if string.find(ninth_line, 'Updated: ') then
            -- Update the updated line
            lines[9] = create_header_line(9)
            -- Update the filename line
            lines[4] = create_header_line(4)
            vim.api.nvim_buf_set_lines(0, 3, 4, false, {lines[4]})  -- Update line 4 (0-indexed as 3)
            vim.api.nvim_buf_set_lines(0, 8, 9, false, {lines[9]})  -- Update line 9 (0-indexed as 8)
            return false
        end
    end
    return true
end

-- Main function to add or update header
local function add_header()
    if update_header() then
        insert_header()
    end
end

-- Define the plugin setup function
function M.setup()
    -- Create the command
    vim.api.nvim_create_user_command('Stdheader', function()
        M.add_header()
    end, {})

    -- Set up keymap for F1
    vim.api.nvim_set_keymap('n', '<F1>', ':Stdheader<CR>', { noremap = true, silent = true })

    -- Set up autocommand to update header on save
    vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = '*',
        callback = function()
            M.update_header()
        end,
    })
end

-- Expose the add_header function
function M.add_header()
    if update_header() then
        insert_header()
    end
end

-- Expose the update_header function
function M.update_header()
    set_file_type()
    
    local lines = vim.api.nvim_buf_get_lines(0, 0, 11, false)
    if #lines >= 9 then
        local ninth_line = lines[9]  -- Lua tables are 1-indexed, so line 9 is at index 9
        
        if string.find(ninth_line, 'Updated: ') then
            -- Update the updated line
            lines[9] = create_header_line(9)
            -- Update the filename line
            lines[4] = create_header_line(4)
            vim.api.nvim_buf_set_lines(0, 3, 4, false, {lines[4]})  -- Update line 4 (0-indexed as 3)
            vim.api.nvim_buf_set_lines(0, 8, 9, false, {lines[9]})  -- Update line 9 (0-indexed as 8)
            return false
        end
    end
    return true
end

return M
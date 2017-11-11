function filecreator (table)
    path = table{1};
    path = 'macros/' + path + '.macros';
    writetable(cell2table(table),path, 'FileType', 'text', 'WriteVariableNames', 0);
end
function  write_to_text_file( data, filename)
    fid = fopen(filename,'wt');
    for i = 1:size(data, 1)
        fprintf(fid, '%g\t', data(i,:));
        fprintf(fid, '\n');
    end
    fclose(fid);
end
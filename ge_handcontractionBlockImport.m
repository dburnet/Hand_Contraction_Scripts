% wrapper function -DHB 6/16

function ge_handcontractionBlockImport(files, outfile)

% ge_tapBlockImport(files, outfile)
%
% Imports a block of files in the required format for Dom Parrott's "TAP" 
% experiments. Uses the ge_parrottImport.m function to resolve markers and
% pre-process data. Uses a dir() object as input! (Will break on a list or
% some other format.
%
% MDT
% 2016.06.13
% Version 0.8.3

    fid = fopen(outfile,'w');
    fprintf(fid, '%6s, %12s, %18s, %24s, %30s, %36s, %42s, %48s, %54s, %60s, %66s,%72s, %78s,%84s, %90s, %96s, %102s, %108s\r\n\, ','Filename,SubjectNumber,SessionNumber,Hand,PreAF3/4,PreF7/8,PreF3/4,PreFC5/6,PreT7/8,PreP7/8,PreO1/2,PostAF3/4,PostF7/8,PostF3/4,PostFC5/6,PostT7/8,PostP7/8,PostO1/2' );
    fprintf(fid, '\n')
    for file = files'
        file.name
        % Subject and condition data:
        cleanname = regexprep(file.name, '\.edf|\.set$','');
        namelist  = strsplit(cleanname, '-');
        subnum    = namelist{1};
        handorder  = namelist{3};
        sessionnumber  = regexprep(namelist{2}, '^S', '');
        % Data analysis to get AIS's:
        x = ge_handContraction(file.name);
        % Write the "obvious" data to the file
        fprintf(fid, '%s,%s,%s,%s,',  file.name, subnum, sessionnumber, handorder);
        fprintf(fid, '%f,%f,%f,%f,%f,%f,%f,', x{3});
        fprintf(fid, '%f,%f,%f,%f,%f,%f,%f\n', x{5});
      
    end
    fclose(fid);
    fclose('all');     % Testing to fix the matlab open file bug!
end


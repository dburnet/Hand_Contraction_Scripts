% wrapper function -DHB 10/4


function ge_handcontractionBlockChopThirds(files, outfile)

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
    fprintf(fid, '%6s, %12s, %18s, %24s, %30s, %36s, %42s, %48s, %54s, %60s, %66s,%72s, %78s,%84s, %90s, %96s, %102s\r\n\, ','Filename,SubjectNumber,SessionNumber,Hand,Pre1.3F3/4,Pre1.3FC5/6,Pre2.3F3/4,Pre2.3FC5/6,Pre3.3F3/4,Pre3.3FC5/6,Cont1.3F3/4,Cont1.3FC5/6,Cont2.3F3/4,Cont2.3FC5/6,Cont3.3F3/4,Cont3.3FC5/6,Post1.3F3/4,Post1.3FC5/6,Post2.3F3/4,Post2.3FC5/6,Post3.3F3/4,Post3.3FC5/6,' );
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
        x = ge_handContractionChopThirds(file.name);
        % Write the "obvious" data to the file
        fprintf(fid, '%s,%s,%s,%s,', file.name, subnum, sessionnumber, handorder);
        fprintf(fid, '%f,%f,%f,%f,%f,%f,%f,', x{3,:});
        fprintf(fid, '%f,%f,%f,%f,%f,%f,%f,', x{4,:});
        fprintf(fid, '%f,%f,%f,%f,%f,%f,%f', x{5,:});
        fprintf(fid, '\n')
    end
    fclose(fid);
    fclose('all');     % Testing to fix the matlab open file bug!
end


function sepa_handContractionBlockImportFO(files, outfile)

% sepa_handcontractionBlockImport(files, outfile)
%
% Imports a block of files in the required format for Dom Parrott's "TAP"
% experiments and also for the hand contrraction study. Uses the
% ge_parrottImport.m function to resolve markers and pre-process data. Uses
% a dir() object as input! (Will break on a list or some other format.
%
% NB: Temporary file for SEPA 2017. 
%
% MDT
% 2016.06.13
% 2017.02.16
% ALPHA

    fid = fopen(outfile,'w');

    % CSV Header Line
    
    fprintf(fid, 'subject,session,hand,preF34,preFC56,postF34,postFC56\n');
    

    for file = files'
        file.name
        
        % Subject and condition data:
        cleanname      = regexprep(file.name, '\.edf|\.set$','');
        namelist       = strsplit(cleanname, '-');
        subnum         = namelist{1};
        handorder      = namelist{3};
        sessionnumber  = regexprep(namelist{2}, '^S', '');
        
        % Data analysis to get AIS's:
        x = sepa_handContraction(file.name);
        
        % Write the data to the file
        fprintf(fid, '%s,%s,%s,',  subnum, sessionnumber, handorder);
        fprintf(fid, '%f,%f,', x{3}(3:4));
        fprintf(fid, '%f,%f\n', x{5}(3:4));
      
    end
    
    fclose(fid);
    fclose('all');     % Testing to fix the matlab open file bug!
end


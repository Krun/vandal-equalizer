% function number = RdVHDL(file, n, m)
%
% Lee el fichero "file" con formato VHDL de 1 unica columna 
% de 'n' bits enteros y 'm' bits fraccionarios, y lo asigna 
% a la variable "number"
%

function number = RdVHDL(file, n, m)

binNum = [];
fid = fopen([file],'r');
binNum = fgets(fid);
while ~(feof(fid)), 
  binNum = [binNum; fgets(fid)];
end;
fclose(fid);

size_binNum = size(binNum);

number = [];
for i=1:size_binNum(1),
  string = binNum(i,:);
  string = strtrim(string);
  if (string(1)=='X')
      continue
  end
  if (string(1)=='U')
      continue
  end
  DecNum=0;

  if (string(1)=='1')
    DecNum=-pow2(n-1);               % Para incluir el complemento a 2.
  end;
  for j=2:length(string)
    digito = str2num(string(j));     % Convierte de cadena a numero.
    DecNum = (pow2(n-j)*digito) + DecNum;
  end;
  number = [number; DecNum];
end;
disp('file read successfully');


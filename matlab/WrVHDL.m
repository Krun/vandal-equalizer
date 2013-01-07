% function WrVHDL(number, n, m, file)
%
% Escribe el vector "number" en el fichero "file" 
% en formato VHDL de 1 unica columna utilizando 
% 'n' bits enteros y 'm' bits fraccionarios.
%

function WrVHDL(number, n, m, file)

if size(number,1) < size(number,2)
    number = transpose(number);
end;

number = number * pow2(m);
digitNumber = n + m;
binNum=[];
number=fix(number)+pow2(digitNumber);
for i=1:digitNumber,    
	binNum =[fix(rem(number,2)), binNum];
	number = number./2;
end;

size_binNum = size(binNum);
fid = fopen(file,'w');
for i=1:size_binNum(1), 
  for j=1:size_binNum(2), 
    fprintf(fid,'%d', binNum(i,j));
  end;
  fprintf(fid,'\r\n');
end;
fclose(fid);
disp('file written successfully');

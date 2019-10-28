function output = reduced_vector (input)

n=length(input);
output=zeros(n,1);
for i=2:n-1         
    output(i)= input(i);
end
 output(1)= (input(1)+input(2))/2;
 output(n)= (input(n)+input(n-1))/2;

end
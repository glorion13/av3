function [ output_args ] = lsePlane( xData, yData, zData, n )

    A(1,1) = sum(xData*yData); A(2,1) = sum(xData*yData); A(3,1) = sum(xData);
    A(1,2) = sum(xData*yData); A(2,2) = sum(yData*yData); A(3,2) = sum(yData);
    A(1,3) = sum(xData);       A(2,3) = sum(yData);       A(3,3) = n;
    
    b(1,1) = sum(xData*zData); b(1,2) = sum(yData*zData); b(1,3) = sum(zData);
    
    output_args = b/A;

end


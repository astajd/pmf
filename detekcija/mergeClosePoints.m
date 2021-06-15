function [ out_points ] = mergeClosePoints( points, epsilon )
%   Usage: call function with nx2 array of points
%   function return (n-m)xn array with points closer than 
%   epsilon merged.

flag = 1;

while(flag)
    flag = 0;
    for i=1:length(points)-1
        for j = i+1:length(points)
            dist = sqrt((points(i,1)-points(j,1))^2 + (points(i,2)-points(j,2))^2);
            if (dist > 0 && dist < epsilon)
                points(i,1) = (points(i,1)+points(j,1))/2;
                points(j,1) = (points(i,1)+points(j,1))/2;
                points(i,2) = (points(i,2)+points(j,2))/2;
                points(j,2) = (points(i,2)+points(j,2))/2;
                flag = 1;
            end
        end
    end
end

[lp, ~] = size(points);

points = unique(points, 'rows');

fprintf('\r %d close points merged.\n',lp - length(points));

xloc = int16(points(:,1));
yloc = int16(points(:,2));

out_points = [xloc yloc];

end


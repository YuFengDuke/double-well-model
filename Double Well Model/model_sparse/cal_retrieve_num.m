function [begin_retrieve_num,end_retrieve_num] = cal_retrieve_num(error_holder)

tolerance = 0;
begin_retrieve_num = 0;
for i = 1:size(error_holder,2)
    if error_holder(i) > 0.1
        begin_retrieve_num = begin_retrieve_num + 1;
    else
        tolerance = tolerance + 1;
    end
    if tolerance > 5
        break;
    end
end


tolerance = 0;
end_retrieve_num = 0;
for i = size(error_holder,2):-1:1
    if error_holder(i) > 0.1
        end_retrieve_num = end_retrieve_num + 1;
    else
        tolerance = tolerance + 1;
    end
    if tolerance > 5
        break;
    end
end


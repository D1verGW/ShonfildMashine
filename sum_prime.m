function sum_prime
f=figure('Position',[10,50 ,1004,650 ], 'MenuBar','none');
bstart=uicontrol('Style' , 'pushbutton','Units' , 'pixels','Position', [550 , 20, 434 , 50],'String','Старт','Callback',@start );
fun = uicontrol('Style' , 'edit' , 'Units' , 'pixels' , 'position' , [550 , 580,  434 ,50]);
sumTable = uicontrol('Style' , 'list' , 'Units' , 'pixels' , 'position' ,[20,20,500,610]);
    function start(~,~)
        fnumber = get(fun,'String');
                pnum = str2num(fnumber);
               
                if mod(pnum,2)==0 && pnum>2;
                    pmas = primes(pnum);
                    psum =isprime(pnum - pmas);
                    p2sum = pmas(psum);
                    p3sum = pnum - p2sum;
                    pmediana = length(p2sum)/2;
                    for i = 1:pmediana
                        
                        a{i} = [num2str(p2sum(i)), '+', num2str(p3sum(i))];
                        
                    end
                    
                    set (sumTable, 'String', a);
                else errordlg('Error!');
                end
    end

end

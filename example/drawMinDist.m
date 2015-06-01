% drawMinDist
% Copyright (C) 2013 Michael Shing 
%
% This program is free software; you can redistribute it and/or
% modify it under the terms of the GNU General Public License
% as published by the Free Software Foundation; either version 2
% of the License, or (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

withinClass = zeros(1,numdata);
betweenClass = [];

 for p = 1:numdata
         
          if mod(p,1000)==0
                fprintf('img NO: %d\n',p);
          end
          
          [EuclideanDistance,sortIndex]= EuclidDist(NH(:,p),NH);
          
           id =2 ;
           while(N_label(sortIndex(id)) ~= N_label(p))
               id = id +1;
           end
           withinClass(p) = EuclideanDistance(id);  
           betweenIndex =sortIndex( N_label(sortIndex)~= N_label(p));
           betweenClass= [betweenClass, EuclideanDistance(betweenIndex)];
 end


allClass = [withinClass,betweenClass];

unqAll = unique(allClass);

th = min(unqAll):0.01:max(unqAll);  %阈值，一共xxx个  

FAR=[];
FRR=[];

numbetween = length(betweenClass);
for i=1:length(th)   
    far = sum(betweenClass<th(i))/numbetween; %小于阈值的  就错误的接受了  
    FAR = [FAR far];  
    
    frr = sum(withinClass>th(i))/numdata;  %大于预设阈值的 就错误的拒绝了  
    FRR=[FRR frr];  
end
  
    plot(th,FAR,'k:',th,FRR, 'k-','linewidth',2);
   legend('FAR','FRR');
    hold on;
   % title(' FAR FRR 曲线');
    hold off;

 %,'linewidth',2,
 [RR ,loc] = min(abs(FAR-FRR));
 
 ERR=(loc-1)*0.01+min(unqAll);
 
 
 
 
 
 
 
 
function hintonDiagram_Exon_HL(w,hl_box)
% Display a matrix W where the square's area represents W(i,j), in this
% version:
% 1: the size of the square represents the average expression level; 
% 2: for color, red = disease sample; green = control sample
% 3: hl_box, marking exons should be highlighted, default all zero
% matrix (no exons will be highlighted)
% 4: Note: for isoforms with missing exons, just assign zeors to those
% positions.
%  Examples: 
%   W = randn(4,5); 
%   W(1,2)=0; W(4,4)=0;
%   hl_box(1:4,1:5)=0;
%   hl_box(3,2)=1;
%   hintonDiagram_HL(W,pos,hl_box)

% Tao Xie 
% 
% Last modified: Feb. 19, 2017
% Based on hintonw function from Mathworks neural net toolbox

if nargin < 2
    error('Not enough input arguments.');
end
max_m = max(max(abs(w))); 
min_m = max_m / 100; 
%max_m = 1; min_m = 0;

% DEFINE BOX EDGES
xn1 = [-1 -1 +1]*0.5;
xn2 = [+1 +1 -1]*0.5;
yn1 = [+1 -1 -1]*0.5;
yn2 = [-1 +1 +1]*0.5;

% DEFINE POSITIVE BOX
xn = [-1 -1 +1 +1 -1]*0.5;
yn = [-1 +1 +1 -1 -1]*0.5;

% DEFINE POSITIVE BOX
xp = [xn [-1 +1 +1 +0 +0]*0.5];
yp = [yn [+0 +0 +1 +1 -1]*0.5];

[S,R] = size(w);

cla reset
hold on
set(gca,'xlim',[0 R]+0.5);
set(gca,'ylim',[0 S]+0.5);
set(gca,'xlimmode','manual');
set(gca,'ylimmode','manual');
xticks = get(gca,'xtick');
set(gca,'xtick',xticks(find(xticks == floor(xticks))))
yticks = get(gca,'ytick');
set(gca,'ytick',yticks(find(yticks == floor(yticks))))
set(gca,'ydir','reverse');
if get(0,'screendepth') > 1
  %set(gca,'color',[1 1 1]*.5);
  %set(gcf,'color',[1 1 1]*.3);
end

for i=1:S
       ii=i;
  for j=1:R
      jj=j;
    m = sqrt((abs(w(i,j))-min_m)/max_m);
    m = min(m,max_m)*0.6;
    w(i,j);
    if real(m)
      if w(i,j) >= 0
        %fill(xn*m+j,yn*m+i,  [0.5172    0.5172    1.0000]);%[0 0.8 0])
        if (hl_box(i,j)>0)
            fill(xn*m+jj,yn*m+ii,[0 0.8 0],'FaceAlpha', 0.9)
        else 
            fill(xn*m+jj,yn*m+ii,[0 0.8 0],'FaceAlpha', 0.1)
        end
        %plot(xn1*m+j,yn1*m+i,'w',xn2*m+j,yn2*m+i,'k');
      elseif w(i,j) < 0
        %fill(xn*m+j,yn*m+i,[0.8 0 0]);
        x = m*sin(-pi:0.1*pi:pi)/2 + j;
        y = 0.5*cos(-pi:0.1*pi:pi)/2 + i;
        if (hl_box(i,j)>0)
            fill(xn*m+jj,yn*m+ii,[0.8 0 0],'FaceAlpha', 0.9)
        else 
            fill(xn*m+jj,yn*m+ii,[0.8 0 0],'FaceAlpha', 0.1)
        end
        
        
      end
    end
  end
end

plot([0 R R 0 0]+0.5,[0 0 S S 0]+0.5,'w');
grid on

%Function to initialize a new 2D figure.

%INPUT:
%The function takes only optional parameters in the following order:
%1. Figure name
%2. 'GridOn'/'GridOff' for the grid
%3. x limits (2*2 array)
%4. y limits (2*2 array)
%It just returns the default figure if there are no input parameters.

%OUTPUT:
%fig: Output figure that was created.
%ax: Axes of the output figure that was created.

function [fig, ax] = initializeFigure2D(varargin)

    %Default figure.
    if nargin == 0
        fig = figure;
        ax = axes(fig);
    end

    %Optional title.
    if nargin == 1
        fig = figure('Name',varargin{1},'NumberTitle','off');
        ax = axes(fig);
    end

    %Optional grid on/ grid off.
    if nargin == 2
        fig = figure('Name',varargin{1},'NumberTitle','off');
        ax = axes(fig);
        if strcmp(varargin{2}, 'GridOn')
            grid on;
        elseif strcmp(varargin{2}, 'GridOff')
            grid off;
        end
    end

    %Optional x limits.
    if nargin == 3
        fig = figure('Name',varargin{1},'NumberTitle','off');
        ax = axes(fig);
        if strcmp(varargin{2}, 'GridOn')
            grid on;
        elseif strcmp(varargin{2}, 'GridOff')
            grid off;
        end
        xlim(ax, varargin{3});
    end

    %Optional y limits.
    if nargin == 4
        fig = figure('Name',varargin{1},'NumberTitle','off');
        ax = axes(fig);
        if strcmp(varargin{2}, 'GridOn')
            grid on;
        elseif strcmp(varargin{2}, 'GridOff')
            grid off;
        end
        xlim(ax, varargin{3});
        ylim(ax, varargin{4});
    end

    %Setting axes labels.
    xlabel('x');
    ylabel('y');
    
end


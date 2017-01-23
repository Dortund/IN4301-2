results = dlmread('D:\Gebruikers\nomen\Documents\IN4301\IN4301-2\graphs\results\results5.txt');

nodes = unique(results(:,5))';
edgeprob = unique(results(:,6))';
maxweight = unique(results(:,7))';

% Variate on amount of nodes
figure;
hold on;
for prob = edgeprob
    for weight = maxweight
        p = results(results(:,6)==prob & results(:,7)==weight,:);
        
        [u,~,n] = unique(p(:,5));
        sz = [size(u,1),1];
        b = [u,accumarray(n,p(:,3),sz)./accumarray(n,1,sz)];
        
        name = strcat('prob=',num2str(prob),', maxWeight=',num2str(weight));
        
        plot(b(:,1),b(:,2)*1000,'DisplayName',name);
        legend('-DynamicLegend','Location','northwest');
        xlabel('Number of nodes');
        ylabel('Calculation time SDP in ms');
    end
end
hold off;

% Variate on amount of nodes LOG
figure;
for prob = edgeprob
    for weight = maxweight
        p = results(results(:,6)==prob & results(:,7)==weight,:);
        
        [u,~,n] = unique(p(:,5));
        sz = [size(u,1),1];
        b = [u,accumarray(n,p(:,3),sz)./accumarray(n,1,sz)];
        
        name = strcat('prob=',num2str(prob),', maxWeight=',num2str(weight));
        
        semilogy(b(:,1),b(:,2)*1000,'DisplayName',name);
        legend('-DynamicLegend','Location','northwest');
        xlabel('Number of nodes');
        ylabel('Calculation time SDP in ms');
        hold on;
    end
end
hold off;

% Variate on max weight of edges
figure;
hold on;
for prob = edgeprob
    for node = nodes
        p = results(results(:,6)==prob & results(:,5)==node,:);
        
        [u,~,n] = unique(p(:,7));
        sz = [size(u,1),1];
        b = [u,accumarray(n,p(:,3),sz)./accumarray(n,1,sz)];
        
        name = strcat('prob=',num2str(prob),',nodes=',num2str(node));
        
        plot(b(:,1),b(:,2)*1000,'DisplayName',name);
        legend('-DynamicLegend','Location','north');
        xlabel('Max weight of edges');
        ylabel('Calculation time SDP in ms');
    end
end
hold off;

% Variate on edge probability
figure;
hold on;
%for weight = maxweight
    for node = nodes
        %p = results(results(:,7)==weight & results(:,5)==node,:);
        p = results(results(:,5)==node,:);
        
        [u,~,n] = unique(p(:,6));
        sz = [size(u,1),1];
        b = [u,accumarray(n,p(:,3),sz)./accumarray(n,1,sz)];
        
        %name = strcat('maxWeight=',num2str(weight),',nodes=',num2str(node));
        name = strcat('nodes=',num2str(node));
        
        plot(b(:,1),b(:,2)*1000,'DisplayName',name);
        legend('-DynamicLegend','Location','north');
        xlabel('Edge probability');
        ylabel('Calculation time SDP in ms');
    end
%end
hold off;

% Variate on amount of edges
figure;
hold on;
for prob = edgeprob(:,1)
    for node = nodes
        p = results(results(:,6)==prob & results(:,5)==node,:);
        
        [u,~,n] = unique(p(:,8));
        sz = [size(u,1),1];
        b = [u,accumarray(n,p(:,3),sz)./accumarray(n,1,sz)];
        
        name = strcat('prob=',num2str(prob),',nodes=',num2str(node));
        
        plot(b(:,1),b(:,2)*1000,'DisplayName',name);
        legend('-DynamicLegend','Location','north');
        xlabel('Amount of edges');
        ylabel('Calculation time SDP in ms');
    end
end
hold off;

% Tightness of bounds
figure;
hist(results(:,2)./results(:,1), 1.005:0.01:1.14);
xlabel('Upper Bound / Lower Bound')
ylabel('Nr of instances')












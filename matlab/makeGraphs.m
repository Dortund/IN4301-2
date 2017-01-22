results = dlmread('D:\Gebruikers\nomen\Documents\IN4301\IN4301-2\graphs\results\results1.txt');

% edgeProb = 0.5 && maxweight = 25
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
for weight = maxweight
    for node = nodes
        p = results(results(:,7)==weight & results(:,5)==node,:);
        
        [u,~,n] = unique(p(:,6));
        sz = [size(u,1),1];
        b = [u,accumarray(n,p(:,3),sz)./accumarray(n,1,sz)];
        
        name = strcat('maxWeight=',num2str(weight),',nodes=',num2str(node));
        
        plot(b(:,1),b(:,2)*1000,'DisplayName',name);
        legend('-DynamicLegend','Location','north');
        xlabel('Edge probability');
        ylabel('Calculation time SDP in ms');
    end
end
hold off;
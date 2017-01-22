path = 'D:\Gebruikers\nomen\Documents\IN4301\IN4301-2\graphs';
cd(path);
graphs = dir('maxcut*');
for graph = graphs'
    C = dlmread(graph.name)
    v = length(C);
    options = sdpsettings('solver','sedumi');
    options.verbose = 0; %Produce no output during calculation
    options.dualize = 1;
    A = sdpvar(v,v);
    objective = 0.5*trace(C' * (1-A));
    constraints = [A >= 0, diag(A) == 1];
    sol = optimize(constraints, -objective, options);
    Z = double(A)
    result = double(objective)
    time = sol.solvertime
    time2 = 0;
    [R,p] = chol(double(A));
    % Do that randomized thingie to get other bound
    if p == 0
        tic    
        avg = roundingGoeWil(R, C, 100)
        time2 = toc
    else
        error = 'Non semidefinite positve matrix'
    end
    totalTime = time+time2
end

function average = roundingGoeWil(vecotrs, graph, iterations)
dim = size(vecotrs,1);
sum = 0;
for itt = 1:iterations
    plane = normrnd(0,1,[dim,1]);
    plane = plane/norm(plane);
    S = [];
    S2 = [];
    for i = 1:size(vecotrs,2) %round
       vector = vecotrs(:,i);
       if vector'*plane > 0
           S = [S i];
       else
           S2 = [S2 i];
       end
    end
    cut = 0;
    for v1 = S
        for v2 = S2
            if v1 < v2
                cut = cut + graph(v1,v2);
            else
                cut = cut + graph(v2,v1);
            end
        end
    end
    sum = sum + cut;
end
average = sum / iterations;
end
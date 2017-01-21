path = 'D:\Gebruikers\nomen\Dropbox\Personal\eclipse workspace\IN4301-Programming2\graphs\';
cd(path);
graphs = dir('maxcut*');
for graph = graphs'
    C = dlmread(graph.name)
    v = length(C);
    options = sdpsettings('solver','sedumi');
    %options.verbose = 0; %Produce no output during calculation
    options.dualize = 1;
    A = sdpvar(v,v)
    objective = 0.5*trace(C' * (1-A))
    constraints = [A >= 0, diag(A) == 1]
    sol = optimize(constraints, -objective, options)
    Z = double(A)
    result = double(objective)
    time = sol.solvertime
    [R,p] = chol(double(A))
    % Do that randomized thingie to get other bound
end
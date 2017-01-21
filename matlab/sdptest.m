options = sdpsettings('solver','sedumi');
A = sdpvar(4,4);
objective = -(1/4) * (15 + A(4,1) - A(4,3) + A(1,3));
constraints = [diag(A) == ones(4,1), A >= 0];
sol = solvesdp(constraints, objective, options);
double(A)
double(-objective)
sol.solvertime
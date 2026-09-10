clc

x = 0.1:1/22:1;
d = ((1 + 0.6*sin(2*pi*x/0.7)) + 0.3*sin(2*pi*x))/2;

plot(x, d);

%% Tinklas init

%% Pirmas sluoksnis
w11_1 = rand(1);
w21_1 = rand(1);
w31_1 = rand(1);
w41_1 = rand(1);

b1_1 = rand(1);
b2_1 = rand(1);
b3_1 = rand(1);
b4_1 = rand(1);

%% Antras sluoksnis

w11_2 = rand(1);
w12_2 = rand(1);
w13_2 = rand(1);
w14_2 = rand(1);
b1_2 = rand(1);

eta = 0.1;

% FeedForward

for iteracija = 1:10000
    for i = 1:length(x)
        % 1 Pasverta suma
        v1_1 = x(i)*w11_1 + b1_1;
        v2_1 = x(i)*w21_1 + b2_1;
        v3_1 = x(i)*w31_1 + b3_1;
        v4_1 = x(i)*w41_1 + b4_1;
    
        % 1 Sluoksnio aktyvacijos funkcija
        y1_1 = tanh(v1_1);
        y2_1 = tanh(v2_1);
        y3_1 = tanh(v3_1);
        y4_1 = tanh(v4_1);
    
        % 2 Pasverta suma
        v1_2 = y1_1*w11_2 + y2_1*w12_2 + y3_1*w13_2 + y4_1*w14_2 + b1_2;
    
        % 2 Sluoksnio aktyvacijos funkcija
        
        % Isejimo sluoksnio aktyvacija
        y1_2 = v1_2;
    
        y = y1_2;
    
        % Klaida    
        e = d(i) - y;
    
        % Svorio atnaujinimas
        % Isejimo sluoksnis
        delta1_2 = e;
        
        % Pasleptas sluoksnis
        delta1_1 = (1 - (tanh(v1_1)^2))*delta1_2*w11_2;
        delta2_1 = (1 - (tanh(v2_1)^2))*delta1_2*w12_2;
        delta3_1 = (1 - (tanh(v3_1)^2))*delta1_2*w13_2;
        delta4_1 = (1 - (tanh(v4_1)^2))*delta1_2*w14_2;
        
        % Atnaujinami svoriai
        % Isejimo sluosknis
        w11_2 = w11_2 + eta*delta1_2*y1_1;
        w12_2 = w12_2 + eta*delta1_2*y2_1;
        w13_2 = w13_2 + eta*delta1_2*y3_1;
        w14_2 = w14_2 + eta*delta1_2*y4_1;
        b1_2 = b1_2 + eta*delta1_2;
        
        % Pasleptojo sluoksnio
        w11_1 = w11_1 + eta*delta1_1*x(i);
        w21_1 = w21_1 + eta*delta2_1*x(i);
        w31_1 = w31_1 + eta*delta3_1*x(i);
        w41_1 = w41_1 + eta*delta4_1*x(i);
        b1_1 = b1_1 + eta*delta1_1;
        b2_1 = b2_1 + eta*delta2_1;
        b3_1 = b3_1 + eta*delta3_1;
        b4_1 = b4_1 + eta*delta4_1;
    end
end

hold on 
x_new = 0.1:1/22:1;
Y = zeros(1, length(x_new));
for i=1:length(x_new)
    % 1 Pasverta suma
    v1_1 = x_new(i)*w11_1 + b1_1;
    v2_1 = x_new(i)*w21_1 + b2_1;
    v3_1 = x_new(i)*w31_1 + b3_1;
    v4_1 = x_new(i)*w41_1 + b4_1;

    % 1 Sluoksnio aktyvacijos funkcija
    y1_1 = tanh(v1_1);
    y2_1 = tanh(v2_1);
    y3_1 = tanh(v3_1);
    y4_1 = tanh(v4_1);

    % 2 Pasverta suma
    v1_2 = y1_1*w11_2 + y2_1*w12_2 + y3_1*w13_2 + y4_1*w14_2 + b1_2;

    % 2 Sluoksnio aktyvacijos funkcija

    % Isejimo sluoksnio aktyvacija
    y1_2 = v1_2;
    Y(i) = y1_2;

end

plot(x_new, Y, 'r');

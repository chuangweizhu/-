
clear;                  % ����������е�����,Ҳ���ǽ�֮ǰ���������
clc;                    % ��������д����е�����
% ����ע�Ϳ�ݼ�CTRL + R ȡ��ע��CTRL + T


% init parameter
N = 1000;               % �����źų��ȣ���������1000Baud
x = randi([0,1],1 ,N)   % �������N��0����1
s_nrz = x;              % �����Բ���������
fb = 1000; %���Ͷ˷�������
fs = 16000; %�˲�������Ƶ��fs = 16000; %�˲�������Ƶ��
alpha = 0.25;           % ����ϵ��
delay = 5;              % ʱ��
snr = -5;               % �����-5�� 5
oversamp = fs/fb;       % ��������
elv = 0                 % ������
c_error = 0;            % �������
f = ((0:N-1)*fs)/N;       % Ƶ�����


% ʹ��ƽ���������Ҷ��� ����rcosdesign(beta,span,sps)
h_sqrt = rcosine(1, oversamp, 'fir/sqrt', alpha, delay); 
% ���Ͷ���Ԫ����������
x_oversamp = kron(s_nrz, [1, zeros(1, oversamp-1)]); 

% ����ʱ��ʹ�þ�����õ�������͵��ź�
x_shaped = conv(x_oversamp, h_sqrt, 'same');

% ����ʱ������
figure('name','���Ͷ��������');
subplot(2, 1, 1);
plot(x_shaped);axis([0 200 -1 1]);
title("����ʱ����");
% ��������Ҷ�任���Ƶ����
f_x = fft(x_shaped,N);    % f_x = fft(x_shaped, N);N ������Ϊ��1000
f_x_abs = abs(f_x);     % ��������Ҷ�任���Ҫȡ����ֵ
% ����Ƶ����
% �������ú����� 
% n = 1:N; x_f = n*fs/N; step(x_f,f_x_abs);
subplot(2, 1, 2);
plot(f,f_x_abs);% axis([0 200 -6 6]);
title("����Ƶ����");
% ==================�������ƽ���������һ�ͼ================================
% ==============���������Ͷ˽���2ASK���ƺ��ʱ���Ƶ����===============

fc = 4000;                  % �ز�Ƶ��

% f_up = 2000                 % �Ϸ�֧�ز�Ƶ��
% f_down = 4000               % �·�֧�ز�Ƶ��

x_len = length(x_shaped);     % �����źų���

ln = 0:x_len - 1;

t = ln/fs;                    % ʱ��t 2ASK����

cari_x = cos(2*pi*fc*t);    % �ز�
m_x_c = x_shaped .* cari_x;  % ģ����˷����е���


% �����ز���Ĳ���
figure('name','2ASK���ƺ�Ĳ���');
subplot(2, 1, 1);
plot(m_x_c);
title("����ʱ����");
axis([0 200 -0.5 0.5]);

% ����Ҷ�任����
f_m_x_c = fft(m_x_c,N);       % m����ģ�⣬c����˷�
f_m_x_c_abs = abs(f_m_x_c);
subplot(2, 1, 2);
stem(f, f_m_x_c_abs);
title("����Ƶ����");
%axis([0 800 -0.5 0.5]);


% ==============���������ն˽���2ASK���ƺ��ʱ���Ƶ����===============


m_x_c_n = awgn(m_x_c, snr, 'measured', 'db');     % ��Ӹ�˹������

% ��ɽ��
x_c_n = m_x_c_n .* cari_x;                          % ��ͬƵ����� .*

figure('name','2ASK���ƺ���ն˵Ĳ���');
subplot(2 , 1, 1);
stem(x_c_n);
title("����ʱ����");
axis([0 200 -1 1]);
f_x_c_n = fft(x_c_n, N);
f_x_c_n_abs = abs(f_x_c_n);

subplot(2, 1, 2);
stem(f, f_m_x_c_abs);
title("����Ƶ����");
%axis([0 200 -1 1]);



% ==============���������ն�ƥ���˲�ʱ���Ƶ����===============

res = conv(x_c_n, h_sqrt);            % ���ն�������ͣ��˲�������ʹ��ƽ����������
figure('name','���ն�ƥ���˲�');
subplot(2, 1, 1);
stem(res);
title("����ʱ����");
axis([0 500 -10 20]);
% ����Ҷ�任
f_res = fft(res, N);
f_res_abs = abs(f_res);
subplot(2, 1, 2);
plot(f, f_res_abs);                        % stem(x_f,f_res_abs);
title("����Ƶ����");


% ===============���Ͷ������źźͽ����о���������źŲ��ζԱ�ͼ============

% ����ͬ��
SynPosi = delay * oversamp * 2 + 1;                 % ����ʱ��*��������
SymPosi = SynPosi + (0:oversamp:(N-1) * oversamp);  % ������

res_signl = res(SymPosi);                           % ���ն˲����ź�



% �о�
res_match = zeros(length(res_signl));               % ��ʼ��һ������������0|1

for i = 1:N
    if res_signl(i) > 0.5
        res_match(i) = 1;
        
    elseif res_signl(i) <= 0.5
        res_match(i) = 0;
        
    end
end

% ��ͼ
figure('name', '�Ƚ����������ź�');
subplot(2, 1, 1);
stem(s_nrz); axis([0 200 -0.5 1.5]);          % �����������ź�
title('�����������ź�');

subplot(2, 1, 2);
stem(res_match); axis([0 200 -0.5 1.5]);       % �����������ź�
title('���ն�ƥ������ź�');        


% ����������
for i = 1:N
    if res_match(i) ~= s_nrz(i)
        c_error = c_error + 1;
        
    end
end

elv = c_error / N;                      % ����elv


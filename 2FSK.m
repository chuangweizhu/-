% clear;                  % ����������е�����,Ҳ���ǽ�֮ǰ���������
% clc;                    % ��������д����е�����
% % ����ע�Ϳ�ݼ�CTRL + R ȡ��ע��CTRL + T
% 
% 
% % init parameter
% N = 1000;               % �����źų��ȣ���������1000Baud
% x = randi([0,1],1 ,N)   % �������N��0����1
% s_nrz = x;              % �����Բ���������
% % 2FSK
% up_x = x;               % �Ϸ�֧
% down = (1-x);              % �·�֧
% fb = 1000;              % ��������1000Baud
% fs = 16000;             % ����Ƶ��
% alpha = 0.25;           % ����ϵ��
% delay = 5;              % ʱ��
% snr = -5;               % �����-5�� 5
% oversamp = fs/fb;       % ��������
% elv = 0                 % ������
% c_error = 0;            % �������
% f = ((0:N-1)*fs)/N;       % Ƶ�������
% 
% % ʹ��ƽ���������Ҷ��� ����rcosdesign(beta,span,sps)
% h_sqrt = rcosine(1, oversamp, 'fir/sqrt', alpha, delay); 
% % ���Ͷ���Ԫ����������
% x_oversamp = kron(s_nrz, [1, zeros(1, oversamp-1)]); 
% 
% % �Ϸ�֧������
% % up_x_oversamp = kron(up_x, [1, zeros(1, oversamp-1)]);
% % �·�֧������
% % down_x_oversamp = kron(dowm_x, [1, zeros(1, oversamp-1)]);
% 
% % ����ʱ��ʹ�þ�����õ�������͵��ź�
% x_shaped = conv(x_oversamp, h_sqrt, 'same');
% 
% % �����ϣ��·�֧���
% %up_x_shaped = conv(up_x_oversamp, h_sqrt, 'same');
% %down_x_shaped = conv(dowm_x_oversamp, h_sqrt, 'same');
% 
% 
% 
% % �����·�֧��
% %figure('name','2FSK ���Ͷ��Ϸ�֧�������')
% % subplot(2, 1, 1);stem(up_x_shaped);title("�Ϸ�֧ʱ����");axis([0 200 -1 1]);
% % f_up_x_shaped = fft(up_x_shaped);f_up_x_shaped_abs = abs(f_up_x_shaped);
% % subplot(2, 1, 2);stem(f, f_up_x_shaped_abs);title('�Ϸ�֧Ƶ��');
% 
% %figure('name','2FSK ���Ͷ��·�֧�������')
% % subplot(2, 1, 1);stem(down_x_shaped);title("�·�֧ʱ����");axis([0 200 -1 1]);
% % f_down_x_shaped = fft(dowm_x_shaped);f_down_x_shaped_abs = abs(f_down_x_shaped);
% % subplot(2, 1, 2);stem(f, f_up_x_shaped_abs);title('�·�֧Ƶ��');
% 
% % ����ʱ������
% figure('name','���Ͷ��������');
% subplot(2, 1, 1);
% plot(x_shaped);axis([0 200 -1 1]);
% title("����ʱ����");
% % ��������Ҷ�任���Ƶ����
% f_x = fft(x_shaped,N);    % f_x = fft(x_shaped, N);N ������Ϊ��1000
% f_x_abs = abs(f_x);     % ��������Ҷ�任���Ҫȡ����ֵ
% % ����Ƶ����
% % �������ú����� 
% % n = 1:N; x_f = n*fs/N; step(x_f,f_x_abs);
% subplot(2, 1, 2);
% plot(f,f_x_abs);% axis([0 200 -6 6]);
% title("����Ƶ����");
% 
% 
% 
% 








clear;                  % ����������е�����,Ҳ���ǽ�֮ǰ���������
clc;                    % ��������д����е�����
% ����ע�Ϳ�ݼ�CTRL + R ȡ��ע��CTRL + T


% init parameter
N = 1000;               % �����źų��ȣ���������1000Baud
x = randi([0,1],1 ,N)   % �������N��0����1
%s_nrz = x;              % �����Բ���������





% 2FSK
up_x = x;               % �Ϸ�֧
down_x = (1-x);           % �·�֧
fb = 1000;              % ��������1000Baud
fs = 16000;             % ����Ƶ��
alpha = 0.25;           % ����ϵ��
delay = 5;              % ʱ��
snr = -5;               % �����-5�� 5
oversamp = fs/fb;       % ��������
elv = 0                 % ������
c_error = 0;            % �������
f = ((0:N-1)*fs)/N;       % Ƶ�������

% ʹ��ƽ���������Ҷ��� ����rcosdesign(beta,span,sps)
h_sqrt = rcosine(1, oversamp, 'fir/sqrt', alpha, delay); 
% ���Ͷ���Ԫ����������
%x_oversamp = kron(s_nrz, [1, zeros(1, oversamp-1)]); 

% �Ϸ�֧������
up_x_oversamp = kron(up_x, [1, zeros(1, oversamp-1)]);
% �·�֧������
down_x_oversamp = kron(down_x, [1, zeros(1, oversamp-1)]);

% ����ʱ��ʹ�þ�����õ�������͵��ź�
% x_shaped = conv(x_oversamp, h_sqrt, 'same');

% �����ϣ��·�֧���
up_x_shaped = conv(up_x_oversamp, h_sqrt);
down_x_shaped = conv(down_x_oversamp, h_sqrt);






% �����·�֧��
figure('name','2FSK ���Ͷ��Ϸ�֧�������')
subplot(2, 1, 1);plot(up_x_shaped);title("�Ϸ�֧ʱ����");axis([0 1000 -0.5 0.5]);
f_up_x_shaped = fft(up_x_shaped,N);f_up_x_shaped_abs = abs(f_up_x_shaped);
subplot(2, 1, 2);plot(f, f_up_x_shaped_abs);title('�Ϸ�֧Ƶ��');%axis([0 1000 0 40]);

figure('name','2FSK ���Ͷ��·�֧�������')
subplot(2, 1, 1);plot(down_x_shaped);title("�·�֧ʱ����");axis([0 1000 -0.5 0.5]);
f_down_x_shaped = fft(down_x_shaped,N);f_down_x_shaped_abs = abs(f_down_x_shaped);
subplot(2, 1, 2);plot(f, f_down_x_shaped_abs);title('�·�֧Ƶ��');%axis([0 1000 0 40]);



f_up = 2000                 % �Ϸ�֧�ز�Ƶ��
f_down = 4000               % �·�֧�ز�Ƶ��


x_up_len = length(up_x_shaped);           % �����źų���
x_down_len = length(down_x_shaped);       % �����źų���

ln_up = 0:x_up_len - 1;
ln_down = 0:x_down_len - 1;


t_up = ln_up/fs;            % �Ϸ�֧ʱ����� 2FSK ����
t_dowm = ln_down/fs;        % �·�֧ʱ����� 2FSK ����

% ==================2FSK����===========================
fsk_x_shape = f_down_x_shaped + f_up_x_shaped;      % ������֧�ϳ�
% ���·�֧�����ز�
carri_up = cos(2*pi*f_up*ln_up);                    % cos(2*pi*f*t)
carri_down = cos(2*pi*f_down*ln_down);
% 
m_x_up = carri_up .* up_x_shaped;
m_x_down = carri_down .* down_x_shaped;                 % ����֮·��ɽ��
m_up_down = m_x_up + m_x_down;                          % ���ƺ�ϳ�
% ������ƺ�ϳɵ�ʱ���Ƶ����
figure('name','2FSK ����֧���ƺϳ�');
subplot(2, 1, 1);
stem(m_up_down);title("---ʱ��");axis([0 1000 -1 1]);
f_m_up_down = fft(m_up_down,N);
f_m_up_down_abs = abs(f_m_up_down);
subplot(2, 1, 2);stem(f, f_m_up_down_abs);title("---Ƶ��");%axis([0 1000 0 1]);



% �ŵ����䣬��Ӹ�˹������
up_shaped_n = awgn(up_x_shaped, snr, 'measured', 'db');
down_shaped_n = awgn(down_x_shaped, snr, 'measured', 'db');         % ����������ź��ǵ���ǰ

% ���ܶ���ɽ��
de_up_shaped_n = up_shaped_n .* carri_up;                           % ��ҪͬƵͬ�������֮·���н��
de_down_shaped_n = down_shaped_n .* carri_down;

% ������2FSK�ǽ���2ASK ��ӣ����зֿ�����Ϳ��ԣ�����һ������ѡ����ʵ�Ƶ��
% ��֧·ʱ�����Ƶ��
figure('name','���ܶ���֧·���ʱ���Ƶ��');
subplot(2,1,1),plot(de_up_shaped_n);axis([0 1000 -1 1]);
title('----���ն���֧·�������ź�ʱ����');                        % ����ʱ����
f_de_up_shaped_n=fft(de_up_shaped_n,N);                             % ���и���Ҷ�任
f_de_up_shaped_n_abs=abs(f_de_up_shaped_n);
subplot(2,1,2),plot(f,f_de_up_shaped_n_abs);
title('----���ܶ���֧·����ź�Ƶ��');                                % ����Ƶ��

% ��֧·
figure('name','���ܶ���֧·���ʱ���Ƶ��');
subplot(2,1,1),plot(de_down_shaped_n);axis([0 1000 -1 1]);
title('----���ն���֧·�������ź�ʱ����');                         % ����ʱ����
f_de_down_shaped_n=fft(de_down_shaped_n,N);                          % ���и���Ҷ�任
f_de_down_shaped_n_abs=abs(f_de_down_shaped_n);
subplot(2,1,2),plot(f,f_de_down_shaped_n_abs);
title('----���ܶ���֧·����ź�Ƶ��');                                 % ����Ƶ��

% ���ն��˲���
%��֧·
recv_up=conv(de_up_shaped_n, h_sqrt);     %�ٴ�Ƶ��˻���ʱ����
figure('name', '----���ն���֧·ƥ���˲�');
subplot(2,1,1),plot(recv_up);axis([0 800 -1 1]);
title('----���ն���֧·ʱ��');  %����ʱ����
f_recv_up=fft(recv_up,N);
f_recv_up_abs=abs(f_recv_up);
subplot(2,1,2),plot(f,f_recv_up_abs);
title('----���ն���֧·Ƶ��');  %����Ƶ��

 
%��֧·
recv_down=conv(de_down_shaped_n,h_sqrt);     %����ź�Ƶ��˻���ʱ����
figure('name', '----���ն���֧·ƥ���˲�');
subplot(2,1,1),plot(recv_down);axis([0 800 -1 1]);
title('----���ն���֧·ʱ��');  %����ʱ����
f_recv_down=fft(recv_down,N);
f_recv_down_abs=abs(f_recv_down);
subplot(2,1,2),plot(f,f_recv_down_abs);
title('----���ն���֧·Ƶ��');  %����Ƶ��
 

% ͬ������
%���ն�ͬ��������
synPosi=delay * oversamp * 2 + 1;
symPosi=synPosi+(0:oversamp:(N-1) * oversamp);
resv_up_signal=recv_up(symPosi);
resv_down_signal=recv_down(symPosi);

% ��ʼ��һ��������0��1
resv_match = zeros(N);

 
%���ն��о�
% �Ƚ��б���
for i=1:N
    if resv_up_signal(i) > resv_down_signal(i)          %  ��֧·�о�ֵ������֧·�о�ֵ ѡ����֧·Ƶ��
        resv_match(i) = 1;
    elseif resv_up_signal(i) < resv_down_signal(i)      %  ��֧·�о�ֵС����֧·�о�ֵ ѡ����֧·Ƶ��
        resv_match(i) = 0;
    end
end


figure('name', '�����о�����');
subplot(2,1,1),stem(resv_match);axis([0 100 -0.5 1.5]);
title('���ն˳�����о���Ĳ���'); 
 
subplot(2,1,2),stem(up_x);axis([0 100 -0.5 1.5]); % up_x Ҳ���ǵ�������Ԫ
title('���Ͷ˵�ԭʼ����'); 
 
% ����������

for i = 1:N
    if resv_match(i) ~= up_x(i)
        c_error = c_error + 1;
    end
end
elv = c_error / N;
sprintf('�����о��������ʣ�%.5f',elv)
 
 
 


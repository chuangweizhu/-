clear;
clc;
%�����ź�
N = 1000; %�������г���Number of symbols
x = randi([0,1],1,N);
%����[0,1]֮����ȷֲ���α�����������Ϊ1sʱ���ڷ������У���������ΪRb=1000
code = 2*x - 1;   %����˫���Բ�������

fb = 1000; %���Ͷ˷�������
fs = 16000; %�˲�������Ƶ��
oversamp = fs / fb; %��������
delay = 5; %�˲���ʱ��
alpha = 0.25; %����ϵ��

%���Ͷ��������

%ƽ�����������˲���h_sqrt
h_sqrt = rcosine(1, oversamp, 'fir/sqrt', alpha, delay);   
sendsignal_oversample = kron(code, [1, zeros(1, oversamp-1)]); 
%���ȶԷ����źŽ��й�����
sendshaped = conv(sendsignal_oversample, h_sqrt);  %Ƶ��˻���ʱ����
%sendshaped��Ϊ����ƽ����������������ͺ��ʱ����
figure(1);
%����ƽ������������������źŵ�ʱ����
subplot(2,1,1),plot(sendshaped);axis([0 800 -1 1]);
title('���Ͷ�ƽ����������������ͺ���ź�ʱ����');

f = (0:N-1)*fs/N;
x1 = fft(sendshaped, N); %�źŵĸ���Ҷ�任
m1 = abs(x1); %ȡ���
subplot(2,1,2),plot(f,m1);   %����ƽ������������������źŵ�Ƶ����
title('���Ͷ�ƽ����������������ͺ��Ƶ����');
xlabel('Ƶ��/Hz');
grid on;

%����
fc = 4000; %�ز�Ƶ��
nt = 0:length(sendshaped) - 1;
carrier_wave1 = cos(2*pi*fc*nt/fs); %�����ز�
modem_wave = sendshaped .* carrier_wave1; %���ƣ�ģ����˷���
figure(2);
subplot(2,1,1),plot(modem_wave);axis([0 800 -1 1]);    %�����ѵ��źŵ�ʱ����
title('���Ͷ˽���2ASK���ƺ���ź�ʱ����');

x2 = fft(modem_wave, N); %���и���Ҷ�任
m2 = abs(x2); %ȡ���
subplot(2,1,2),plot(f,m2); %�����ѵ��źŵ�Ƶ����
xlabel('Ƶ��/Hz');
title('���Ͷ˽���2ASK���ƺ���ź�Ƶ��');
grid on;

%�ŵ����� �����˹������
snr = 10; %�����
TransSignal = awgn(modem_wave, snr,'measured','db'); %TransSignalΪ�����ŵ������õ����ź�


%���ն���ɽ��
wave1 = TransSignal .* carrier_wave1; %�����뷢�Ͷ�ͬƵͬ����ز� 
figure(3);
subplot(2,1,1),plot(wave1); axis([0 800 -1 1]);  %�������ն˾������������źŵ�ʱ����
title('���ն˽��н������ź�ʱ����');

x3 = fft(wave1, N); %�źŵĸ���Ҷ�任
m3 = abs(x3); %ȡ���
subplot(2,1,2),plot(f,m3); %�������ն˾������������źŵ�Ƶ����
xlabel('Ƶ��/Hz');
title('���ն˽��н������ź�Ƶ��');


%���ն˵�ͨ�˲���
RecMatched1 = conv(wave1, h_sqrt);  %Ƶ��˻���ʱ����
figure(4);
subplot(2,1,1),plot(RecMatched1);axis([0 800 -1 1]);%�������ն˽��պ���źŵ�ʱ����
title('���ն˽���ƥ���˲����ʱ����');

x4 = fft(RecMatched1, N); %�źŵĸ���Ҷ�任
m4= abs(x4); %ȡ���
subplot(2,1,2),plot(f,m4);   %�������ն˽��պ���źŵ�Ƶ����
xlabel('Ƶ��/Hz');
title('���ն˽���ƥ���˲����Ƶ��');
grid on;

%���ն�ͬ��
SynPosi = delay * oversamp * 2 + 1;
SymPosi = SynPosi + (0:oversamp:(N-1) * oversamp);
RecSignal1 = RecMatched1(SymPosi);   %��������������


%���ն˲��� 
RecBit1 = zeros(N); %��ʼ��һ������Ϊ N ��ȫ�����飬��Ž��ն˳����о��õ��ĵ���������
for i = 1:N
    if RecSignal1(i)>0
        RecBit1(i)=1;
    elseif RecSignal1(i)<0
        RecBit1(i)=-1;
    end
end

figure(5);
subplot(2,1,1),stem(code,'.');axis([0 100 -1 1]);
title('���Ͷ˷��͵�����');
subplot(2,1,2),stem(RecBit1,'.');axis([0 100 -1 1]);
title('���ն˶˳����о���õ�������');
grid on;

%������
k = 0;
for i = 1:N
    if RecBit1(i) ~= code(i)
        k = k + 1;
    end
end
error1 = k / N;
sprintf('�����ʣ�%2.2f%',error1);



%�����������

%���ն���ɽ��
%���ն�����ز���cos(wt+��)�����
carrier_wave2 = cos(2*pi*fc*nt/fs + pi); %���ն��ڵ�pi����
wave2 = TransSignal .* carrier_wave2; %�����뷢�Ͷ�ͬƵͬ����ز� 
figure(6);
subplot(2,1,1),plot(wave2); axis([0 800 -1 1]);  %�������ն˾������������źŵ�ʱ����
title('���ն˽��н���󵹦е��ź�ʱ����');
 
x32 = fft(wave2, N); %�źŵĸ���Ҷ�任
m32 = abs(x32); %ȡ���
subplot(2,1,2),plot(f,m32);  %�������ն˾������������źŵ�Ƶ����
xlabel('Ƶ��/Hz');
title('���ն˽��н���󵹦е��ź�Ƶ��');
grid on;

%���ն˵�ͨ�˲���
RecMatched2 = conv(wave2, h_sqrt);  %Ƶ��˻���ʱ����
figure(7);
subplot(2,1,1),plot(RecMatched2);axis([0 800 -1 1]);%�������ն˽��պ���źŵ�ʱ����
title('���ն˽���ƥ���˲��󵹦е�ʱ����');
 
x42 = fft(RecMatched2, N); %�źŵĸ���Ҷ�任
m42 = abs(x42); %ȡ���
subplot(2,1,2),plot(f,m42);    %�������ն˽��պ���źŵ�Ƶ����
xlabel('Ƶ��/Hz');
title('���ն˽���ƥ���˲��󵹦е�Ƶ��');
grid on;

%���ն�ͬ��
RecSignal2 = RecMatched2(SymPosi);   %������������

%���ն˲���
RecBit2 = zeros(N); %��ʼ��һ������Ϊ N ��ȫ�����飬��Ž��ն˳����о��õ��ĵ���������
for i = 1:N
    if RecSignal2(i)>0
        RecBit2(i)=1;
    elseif RecSignal2(i)<0
        RecBit2(i)=-1;
    end
end

figure(8);
subplot(2,1,1),stem(code,'.');axis([0 100 -1 1]);
title('���Ͷ˷��͵�����');
subplot(2,1,2),stem(RecBit2,'.');axis([0 100 -1 1]);
title('���ն˷��͵�����������о���õ�������');
grid on;

%������
j = 0;
for m = 1:N
    if RecBit2(m) ~= code(m)
        j = j + 1;
    end
end
error2 = j / N;
sprintf('�����ʣ�%2.2f%',error2);
 




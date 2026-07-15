%% deviation_plot.m
% 计算与绘制炮弹（或自由落体）在地转偏转中的东西/南北方向偏移
% 与原 Mathematica 代码严格等价
% --------------------------------------------------------------

clear; clc;

%% 常数
R     = 6.3710087666e6;          % 地球半径 (m)
omega = 2*pi/86400;              % 自转角速度 (rad/s)
mu    = 6.67430e-11 * 5.9722e24; % GM  (m^3/s^2)

%%--- 可调参数 -----------------------------------------------------
h = 100000;        % 射高 / 起始相对地面高度 (m)
phiDeg = 0:0.25:90;          % 纬度 (°) 采样
% -----------------------------------------------------------------

phi = deg2rad(phiDeg);       % 转为弧度

%% 东西方向偏函数 f(h,phi) 与南北方向偏函数 g(h,phi)
%（写成局部函数以便向量化计算）
[fVals, gVals] = deviations(h, phi, R, omega, mu);

%% 绘图
figure('Units','pixels','Position',[200 200 640 420]);
plot(phiDeg, fVals, 'LineWidth',1.4);  hold on;
plot(phiDeg, gVals, 'LineWidth',1.4);
grid on; grid minor;
xlabel('Latitude (°)');
ylabel('Deviation (m)');
title(sprintf('Deviation vs Latitude (h = %.0f m)', h));
legend({'East–west deviation  (east = +)', ...
        'North–south deviation (north = +)'}, ...
        'Location','best');
set(gca,'FontSize',11);
tightfig;      % 若已安装 tightfig，可去掉多余留白

%% 保存矢量 PDF（适合论文/幻灯片）
print(gcf,'-dpdf','-r300','deviation_plot.pdf');

%% 局部函数 --------------------------------------------------------
function [f, g] = deviations(h, phi, R, omega, mu)
    a = mu*(R+h) ./ (2*mu - (R+h).^3 .* omega.^2 .* cos(phi).^2);
    b = sqrt(((R+h).^5 .* omega.^2 .* cos(phi).^2) ...
            ./ (2*mu - (R+h).^3 .* omega.^2 .* cos(phi).^2));
    c = sqrt(a.^2 - b.^2);
    e = c ./ a;
    p = b.^2 ./ a;
    alpha1 = acos((R - p) ./ (e .* R));

    f = (atan(tan(alpha1)./cos(phi)) ...
        - (p.^2 ./ ((R+h).^2 .* cos(phi))) ./ (1 - e.^2) ...
          .* ((e .* sin(alpha1)) ./ (1 - e .* cos(alpha1)) ...
          + 2./sqrt(1 - e.^2) ...
            .* atan(sqrt((1+e)./(1-e)) .* tan(alpha1/2)))) ...
        .* R .* cos(phi);

    g = (atan(sin(phi) ./ sqrt(tan(alpha1).^2 + cos(phi).^2)) ...
        - phi) .* R;
end

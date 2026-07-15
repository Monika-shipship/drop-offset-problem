%% deviation_parametric.m
% 生成地转偏移 (f,g) 的参数曲线并保存 PDF
% --------------------------------------------------------------

clear; clc;

%% ---------- 用户可修改的三项参数 -------------------------------
phiDeg = 40;       % 纬度 (°)      — 对应 Mathematica 的 \[Phi]
hHigh  = 25000;    % 最高高度 (m)  — 对应 hhigh
stepH  = 50;       % 采样步长 (m)
%% ---------------------------------------------------------------

%% 常量
R     = 6.3710087666e6;            % 地球半径 (m)
omega = 2*pi/86400;                % 自转角速度 (rad/s)
mu    = 6.67430e-11*5.9722e24;     % GM (m^3/s^2)

%% --- 子函数: 东西/南北偏移 -------------------------------------
deviations = @(h,phi) localDeviation(h,phi,R,omega,mu);

%% (1) 先做一次全局采样，锁定坐标系范围 + 1 m:1 m 比例 ----------
hSample       = 1:5000:30000;              % 1 m … 30 km  每 5 km
phiSampleRad  = deg2rad(1:0.5:89);         % 1° … 89° 每 0.5°
[F,S]         = arrayfun(@(ph) deviations(hSample,ph), ...
                         phiSampleRad,'UniformOutput',false);
F             = [F{:}];             % 所有 f
S             = [S{:}];             % 所有 g
xMin = min(F);  xMax = max(F);
yMin = min(S);  yMax = max(S);
ratio = (yMax - yMin)/(xMax - xMin);       % 1 m:1 m 纵横比例

%% (2) 计算指定纬度 φ 的整条曲线 ------------------------------
h      = 0:stepH:hHigh;                 % 0 → hHigh
phiRad = deg2rad(phiDeg);
[f,g]  = deviations(h,phiRad);

%% (3) 绘图 ----------------------------------------------------
figW = 6;                       % 图宽 (英寸)
figH = figW * ratio;            % 图高 = 宽 × 比例
figure('Units','inches','Position',[1 1 figW figH]);

plot(f,g,'LineWidth',1.8,'Color',[0.85 0.15 0.15]); hold on;
grid on; grid minor;
xlim([xMin xMax]); ylim([yMin yMax]);
axis equal;                             % 1 m : 1 m
xlabel('East–west deviation/ m  (east = +) ','FontSize',11);
ylabel('North–south deviation/ m (north = +) ','FontSize',11);
title('deviation parametric','FontSize',12);

txt = sprintf('Latitude  \\phi = %.1f°\\newline height h = 0 – %.0f m', ...
               phiDeg, hHigh);
annotation('textbox',[0.72 0.82 0.25 0.15],'String',txt,...
           'FontSize',11,'FontWeight','bold',...
           'EdgeColor','none','BackgroundColor',[1 1 1 0.65]);

%% (4) 保存矢量 PDF (放大不失真) -------------------------------
print(gcf,'-dpdf','-r300','deviation_parametric_phi40.pdf');

disp('PDF 已生成： deviation_parametric_phi40.pdf');

%% ----------- 局部函数 -----------------------------------------
function [f,g] = localDeviation(h,phi,R,omega,mu)
    a = mu*(R+h) ./ (2*mu - (R+h).^3 .* omega.^2 .* cos(phi).^2);
    b = sqrt(((R+h).^5 .* omega.^2 .* cos(phi).^2) ...
        ./ (2*mu - (R+h).^3 .* omega.^2 .* cos(phi).^2));
    c = sqrt(a.^2 - b.^2);
    e = c ./ a;
    p = b.^2 ./ a;
    alpha1 = acos((R - p)./(e.*R));

    f = (atan(tan(alpha1)./cos(phi)) ...
        - (p.^2 ./ ((R+h).^2 .* cos(phi))) ./ (1-e.^2) ...
          .* ((e.*sin(alpha1))./(1-e.*cos(alpha1)) ...
          + 2./sqrt(1-e.^2) ...
            .* atan(sqrt((1+e)./(1-e)) .* tan(alpha1/2)))) ...
        .* R .* cos(phi);

    g = (atan(sin(phi)./sqrt(tan(alpha1).^2 + cos(phi).^2)) ...
        - phi) .* R;
end

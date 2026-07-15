%% h_root_vs_phi.m  —  计算满足 f(h,φ)+g(h,φ)=0 的最小高度 hRoot
%  并绘制 hRoot 对 φ 的曲线（含 seed 散点）
% ------------------------------------------------------------------------

clear; clc;

%% 常量
R     = 6.3710087666e6;          % 地球半径 (m)
omega = 2*pi/86400;              % 地球自转角速度 (rad/s)
mu    = 6.67430e-11 * 5.9722e24; % GM (m^3/s^2)

%% ---------------------- f, g, FG 函数 -------------------------------
f = @(h,phi) f_dev(h,phi,R,omega,mu);
g = @(h,phi) g_dev(h,phi,R,omega,mu);
FG= @(h,phi) f(h,phi)+g(h,phi);            % 求根目标

%% seed 表（φ, h）  —  与 Mathematica 保持一致
seed = [...
     2,   30.5;  4, 120.5;   6, 270.0;  8, 478.5; 10,  745.0; 12, 1068.0;
    14, 1446.5; 16,1878.0;  18,2361.5; 20,2894.0; 22, 3474.0; 24, 4097.5;
    26,4762.5;  28,5465.5;  30,6203.5; 32,6973.0; 34, 7770.0; 36, 8591.0;
    38,9432.5;  40,10290;  42,11159;  44,12036;  46,12917;  48,13796.5;
    50,14671.5; 52,15537;  54,16388.5; 56,17222.5; 58,18034.5; 60,18820.5;
    62,19576.5; 64,20298.5; 66,20983;  68,21626.5; 70,22226;  72,22778;
    74,23279.5; 76,23728.5; 78,24123;  80,24459.5; 82,24738;  84,24955.5;
    86,25112;   88,25206;  90,25206];

phiSeed = seed(:,1);  hSeed = seed(:,2);
guessFun = @(phiDeg) interp1(phiSeed,hSeed,phiDeg,'spline','extrap'); % 初猜

%% 割线法求根（不要求异号）
secant = @(phiDeg,h0,eps,maxIt) ...
    localSecant(@(h)FG(h,deg2rad(phiDeg)),h0,1.05*h0,eps,maxIt);

%% φ 网格并求解 hRoot
phiGrid = 1:0.2:89.8;
hRoot   = nan(size(phiGrid));
for k = 1:numel(phiGrid)
    h0 = guessFun(phiGrid(k));
    if h0<=0 || ~isfinite(h0), continue; end
    hRoot(k) = secant(phiGrid(k),h0,1e-8,200);
end

% 过滤成功收敛点
mask  = isfinite(hRoot);
phiOK = phiGrid(mask);   hOK = hRoot(mask);

fprintf('成功收敛点数： %d / %d\n', numel(hOK), numel(phiGrid));

%% 绘图
figure('Units','pixels','Position',[200 200 640 420]);
plot(phiOK,hOK,'LineWidth',1.8,'Color',[0.5 0 0.8]); hold on;
scatter(phiSeed,hSeed,36,'filled','MarkerEdgeColor','k','MarkerFaceColor','w');
grid on; grid minor;
xlabel('Latitude \phi  /  °','FontSize',11);
ylabel('height h  /  m','FontSize',11);
title('hRoot(\phi)  —  f(h,\phi)+g(h,\phi)=0','FontSize',12);
legend({'Numerical roots','Rough-estimate points'},'Location','northwest');
tightfig;      % 若安装 tightfig，可收紧多余边距

%% 保存 PDF（矢量）
print(gcf,'-dpdf','-r300','h_root_vs_phi.pdf');

disp('PDF 已生成： h_root_vs_phi.pdf');

%% -------------------- 局部函数区域 -------------------------------
function y = f_dev(h,phi,R,omega,mu)
    a = mu*(R+h) ./ (2*mu - (R+h).^3 .* omega.^2 .* cos(phi).^2);
    b = sqrt(((R+h).^5 .* omega.^2 .* cos(phi).^2) ...
        ./ (2*mu - (R+h).^3 .* omega.^2 .* cos(phi).^2));
    c = sqrt(a.^2 - b.^2);
    e = c ./ a;
    p = b.^2 ./ a;
    alpha1 = acos((R - p)./(e.*R));
    y = (atan(tan(alpha1)./cos(phi)) ...
        - (p.^2 ./ ((R+h).^2 .* cos(phi))) ./ (1-e.^2) ...
          .* ((e.*sin(alpha1))./(1-e.*cos(alpha1)) ...
          + 2./sqrt(1-e.^2) ...
            .* atan(sqrt((1+e)./(1-e)).*tan(alpha1/2)))) ...
        .* R .* cos(phi);
end

function y = g_dev(h,phi,R,omega,mu)
    a = mu*(R+h) ./ (2*mu - (R+h).^3 .* omega.^2 .* cos(phi).^2);
    b = sqrt(((R+h).^5 .* omega.^2 .* cos(phi).^2) ...
        ./ (2*mu - (R+h).^3 .* omega.^2 .* cos(phi).^2));
    c = sqrt(a.^2 - b.^2);
    e = c ./ a;
    p = b.^2 ./ a;
    alpha1 = acos((R - p)./(e.*R));
    y = (atan(sin(phi)./sqrt(tan(alpha1).^2 + cos(phi).^2)) - phi) .* R;
end

function root = localSecant(F,h0,h1,eps,maxIt)
    f0 = F(h0); f1 = F(h1);
    for i = 1:maxIt
        if abs(f1-f0) < 1e-14, break; end
        h2 = h1 - f1*(h1-h0)/(f1-f0);
        if h2<=0, h2 = h1/2; end
        f2 = F(h2);
        if abs(f2) < eps, root = h2; return; end
        h0=h1; f0=f1; h1=h2; f1=f2;
    end
    root = NaN;                               % 未收敛
end

within SPICELib.src;


function Rect2Polar
   input  Real             rect[2];
   output Real             module;
   output nonSI.Angle_deg  angle;
protected
   SI.Angle       angFirst;
   constant  Real pi = 3.14159265358979;
algorithm
   module := sqrt ( rect * rect );
   angFirst := if not module > 0
               then 0
               else arcsin( abs(rect[2]) / module );
   angle := if rect[1] <0
            then pi - angFirst
            else angFirst;
   angle := if rect[2] < 0
            then - angle
            else   angle;
   angle := 180 * angle / pi;
end Rect2Polar;

function Decibels
   input  Real x;
   output Real x_dB;
algorithm
   x_dB := if x>0 then 20 * ln( x ) / ln(10) else -1e-100;
end Decibels;

function Rad2Deg
   input  SI.Angle        angle_rad;
   output nonSI.Angle_deg angle_deg;
protected
   constant   Real  pi = 3.14159265358979;
algorithm
   angle_deg := 180 * angle_rad / pi;
end Rad2Deg;

function Deg2Rad
   input  nonSI.Angle_deg angle_deg;
   output SI.Angle        angle_rad;
protected
   constant   Real  pi = 3.14159265358979;
algorithm
   angle_rad := pi * angle_deg / 180;
end Deg2Rad;



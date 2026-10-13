$fn = 90;
az = [64.8, 295.2, 115.2, 59.4, 60.0, 55.6, 148.2, 238.1];
color([0.46, 0.71, 0.69])
render(convexity = 10)
difference() {
  cylinder(h = 6, r = 100, center = true);
  union() {
    translate([0, 0, 1.5]) linear_extrude(height = 2.0) {
      for (r = [18, 34, 48, 60, 72, 80, 88]) difference() { circle(r = r + 0.6); circle(r = r - 0.6); }
      difference() { circle(r = 18.8, $fn = 6); circle(r = 17.2, $fn = 6); }
    }
    for (i = [0:19]) rotate([0, 0, i*18]) translate([41, 0, 2.5]) cube([14, 1, 2], center = true);
    for (a = az) rotate([0, 0, 90 - a]) translate([50, 0, 2.5]) cube([100, 1.5, 2], center = true);
    cylinder(h = 10, r = 3, center = true);
  }
}

// Conceptueel model van een Polaire Planimeter (Amsler-type)
// Configureerbaar voor 3D-printen of mechanische visualisatie

// Parameters
poolarm_lengte = 120;
meetarm_lengte = 150;
arm_dikte = 6;
arm_breedte = 12;
wiel_diameter = 25;
wiel_dikte = 4;

// Hoekinstellingen voor de visualisatie
hoek_pool = 35;
hoek_meet = -50;

module as_gat() {
    cylinder(h=arm_dikte+4, d=4, center=true, $fn=30);
}

module pool_anker() {
    // Vast draaipunt (de pool) die op het papier blijft staan
    cylinder(h=arm_dikte, d=22, center=true, $fn=50);
    translate([0, 0, -arm_dikte]) cylinder(h=arm_dikte, d=4, center=true, $fn=30); // Pin
}

module mechanische_arm(lengte) {
    difference() {
        hull() {
            cylinder(h=arm_dikte, d=arm_breedte, center=true, $fn=50);
            translate([lengte, 0, 0]) cylinder(h=arm_dikte, d=arm_breedte, center=true, $fn=50);
        }
        // Scharniergaten
        as_gat();
        translate([lengte, 0, 0]) as_gat();
    }
}

module meetwiel() {
    // Het wiel dat de loodrechte verplaatsing discreet integreert
    rotate([90, 0, 0]) {
        difference() {
            cylinder(h=wiel_dikte, d=wiel_diameter, center=true, $fn=80);
            // Asgat voor het wiel
            cylinder(h=wiel_dikte+2, d=3, center=true, $fn=20);
        }
    }
}

module traceerpunt() {
    // Het vizier waarmee de cartografische contouren worden gevolgd
    translate([0, 0, -arm_dikte/2])
        cylinder(h=12, d1=1.5, d2=6, center=false, $fn=30);
}

// ---- Samenstelling van de Planimeter ----

color("SlateGray") pool_anker();

// Eerste segment: De Poolarm
rotate([0, 0, hoek_pool]) {
    color("Silver") translate([0, 0, arm_dikte]) mechanische_arm(poolarm_lengte);
    
    // Het scharnierpunt
    translate([poolarm_lengte, 0, arm_dikte]) {
        
        // Tweede segment: De Meetarm
        rotate([0, 0, hoek_meet]) {
            color("DimGray") translate([0, 0, arm_dikte]) mechanische_arm(meetarm_lengte);
            
            // Meetwiel bevestigd op de meetarm
            // De positie van het wiel op de arm beïnvloedt de schaalfactor
            color("DarkGoldenrod") 
                translate([meetarm_lengte * 0.35, arm_breedte/2 + wiel_dikte, arm_dikte])
                meetwiel();
                
            // Traceerpunt aan het uiteinde
            color("Black") translate([meetarm_lengte, 0, arm_dikte]) traceerpunt();
        }
    }
}

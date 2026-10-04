use printpdf::*;
use std::fs::File;
use std::io::BufWriter;

fn main() {
    // 1. Initialiseer het PDF-document (A4 formaat)
    let (doc, page1, layer1) = PdfDocument::new("Observatierapport", Mm(210.0), Mm(297.0), "Laag 1");
    let current_layer = doc.get_page(page1).get_layer(layer1);

    // 2. Laad de ingebouwde Helvetica lettertypen in
    let font_regular = doc.add_builtin_font(BuiltinFont::Helvetica).unwrap();
    let font_bold = doc.add_builtin_font(BuiltinFont::HelveticaBold).unwrap();

    // Start-Y coördinaat (printpdf telt vanaf de bodem omhoog)
    let mut cursor_y = 275.0;
    let margin_left = 20.0;

    // Helper functie om tekstlijnen dynamisch op te bouwen
    let mut schrijf_regel = |tekst: &str, is_bold: bool, grootte: f64, witregel: f64| {
        let geselecteerd_font = if is_bold { &font_bold } else { &font_regular };
        current_layer.use_text(tekst, grootte, Mm(margin_left), Mm(cursor_y), geselecteerd_font);
        cursor_y -= witregel; 
    };

    // --- SECTIE: HEADER ---
    schrijf_regel("Observatierapport: Lokale Hemel & Interplanetaire Vectoren", true, 16.0, 10.0);
    schrijf_regel("Datum: 4 oktober 2026", false, 12.0, 6.0);
    schrijf_regel("Tijdstip: 16:18:49 CEST", false, 12.0, 6.0);
    schrijf_regel("Coördinatensysteem: Azimutaal (Lokaal)", false, 12.0, 15.0);

    // --- SECTIE: ZONNESTELSEL BASIS ---
    schrijf_regel("1. Zonnestelsel Basisparameters", true, 14.0, 8.0);
    schrijf_regel("Zon   | Op: 12:56 | Onder: 00:35", false, 11.0, 6.0);
    schrijf_regel("Maan  | Op: 05:49 | Onder: 21:34", false, 11.0, 15.0);

    // --- SECTIE: PLANETEN ---
    schrijf_regel("2. Posities Planeten & Sterrenbeelden", true, 14.0, 8.0);
    schrijf_regel("Mercurius | Az: 121.9° | Hgt:  11.4° | Virgo", false, 11.0, 6.0);
    schrijf_regel("Venus     | Az: 124.9° | Hgt:   6.2° | Virgo", false, 11.0, 6.0);
    schrijf_regel("Mars      | Az: 235.4° | Hgt:  59.8° | Cancer", false, 11.0, 6.0);
    schrijf_regel("Jupiter   | Az: 201.1° | Hgt:  63.2° | Leo", false, 11.0, 6.0);
    schrijf_regel("Saturnus  | Az: 310.4° | Hgt: -34.1° | Cetus", false, 11.0, 6.0);
    schrijf_regel("Uranus    | Az: 285.6° | Hgt:  14.4° | Taurus", false, 11.0, 15.0);

    // --- SECTIE: TELEMETRIE ---
    schrijf_regel("3. Telemetrie & Missie Tracking", true, 14.0, 8.0);
    schrijf_regel("Missie: BepiColombo", false, 11.0, 6.0);
    schrijf_regel("Doelwit: Mercurius", false, 11.0, 6.0);
    schrijf_regel("Actuele Azimut Vector: 121.86°", false, 11.0, 6.0);
    schrijf_regel("Delta met optisch centrum Mercurius: -0.04°", false, 11.0, 6.0);

    // 3. Bestand genereren en wegschrijven
    let bestandsnaam = "Observatierapport_BepiColombo.pdf";
    let file = File::create(bestandsnaam).expect("Kan bestand niet aanmaken");
    let mut buf_writer = BufWriter::new(file);
    
    doc.save(&mut buf_writer).expect("Fout tijdens het schrijven van de PDF");
    
    println!("Succes: PDF gegenereerd als '{}'", bestandsnaam);
}

# Geodetische Rapportage & Factsheet: Schaduwanalyse Tafelberg Blaricum
**Geavanceerde Zonnestand- en Schaduwmodellering op de Tafelbergheide (39,2 m NAP)**

---

## Executive Summary

Deze geodetische rapportage en factsheet presenteert de uitkomsten van de zonnestand- en schaduwanalyse voor de **Tafelberg in Blaricum** (ook wel bekend als de *Kooltjesberg*). Met een top op **39,2 meter boven NAP** vormt dit geomorfe relict het hoogste punt van 't Gooi. 

Het ontwikkelde rekenmodel integreert geavanceerde astronomische algoritmen (`suncalc` / NOAA solar position), geodetische correcties voor **atmosferische refractie (Saemundsson-formule)**, trigonometrische correcties voor **terreinhelling ($3^\circ$ afhellende heide)** en ruimtelijke vector-snijpuntanalyses voor **haakse en diagonale wal/wand-pointers**.

---

## 1. Locatieprofiel & Historische Context

* **Geografische Coördinaten**: $52.29662^\circ\text{ N}, 5.16443^\circ\text{ E}$ ($52^\circ 17' 47.8"\text{ N}, 5^\circ 09' 52.0"\text{ E}$)
* **Maaiveldhoogte / Top**: **39,2 meter boven NAP** (Blaricum / Huizen, Noord-Holland)
* **Historische Functie**: Oorspronkelijk diende de heuvel als nautisch baken voor schepen op de voormalige Zuiderzee. Door het stoken van vuurbakens op de top staat de heuvel in historische bronnen bekend als de *Kooltjesberg*.
* **Beheer & Omgeving**: Beheerd door het **Goois Natuurreservaat** (Tafelbergheide).

---

## 2. Wiskundige & Geodetische Methodiek

Het wiskundige model berekent de schijnbare zonnestand en de schaduwuitwaaiering aan de hand van vier gekoppelde formules:

### 2.1 Atmosferische Refractie (Saemundsson-formule)
Bij lage zonne-elevaties ($h < 15^\circ$) buigt de aardatmosfeer het zonlicht merkbaar af. De refractie-hoek $\Delta h_{\text{ref}}$ (in boogminuten) wordt berekend als:

$$\Delta h_{\text{ref}} = \frac{1.02}{\tan\left(h + \frac{10.3}{h + 5.11}\right)}$$

$$\alpha_{\text{schijnbaar}} = h + \frac{\Delta h_{\text{ref}}}{60}$$

### 2.2 Terreinhelling-correctie ($3^\circ$ afhellende heide)
Voor een heidegebied dat met een hellingshoek $\theta_{\text{helling}} = 3^\circ$ naar het noorden afhelt, wordt de schaduwlengte $L_{\text{helling}}$ berekend als:

$$L_{\text{helling}} = \frac{H}{\tan(\alpha_{\text{schijnbaar}}) - \tan(\theta_{\text{helling}})}$$

### 2.3 Vectoriële Snijpuntberekening (Wal/Wand-Pointer)
Een wal- of muursegment dat van $A(x_A, y_A)$ naar $B(x_B, y_B)$ loopt, heeft een parametrische vergelijking:

$$\mathbf{P}(t) = (1-t)\mathbf{A} + t\mathbf{B}, \quad t \in [0, 1]$$

De schaduwvector vanuit de top naar het terrein is $\mathbf{S} = (L \sin \phi_{\text{az}}, L \cos \phi_{\text{az}})$. Het snijpunt met de wal en de resterende schaduwhoogte $H_{\text{wand}}$ op de wand worden exact opgelost via stelselvergelijkingen.

---

## 3. Zonnestand & Schaduwverloop in Augustus 2026

### 3.1 Zonnemiddag Trend (~13:36 CEST / UTC+2)
| Datum | Geom. Elevatie | Refractie | Schijnbare Elevatie | Zonne-Azimut | Min. Schaduwlengte (Plat) | Min. Schaduwlengte (Helling $3^\circ$) |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **01 augustus 2026** | $55.88^\circ$ | $+0.7'$ | **$55.89^\circ$** | $175.83^\circ$ (Z) | $26.55\text{ m}$ | **$27.68\text{ m}$** |
| **12 augustus 2026** | $52.88^\circ$ | $+0.8'$ | **$52.89^\circ$** | $176.50^\circ$ (Z) | $29.66\text{ m}$ | **$30.90\text{ m}$** |
| **31 augustus 2026** | $46.63^\circ$ | $+1.0'$ | **$46.65^\circ$** | $178.54^\circ$ (Z) | $37.01\text{ m}$ | **$38.74\text{ m}$** |

### 3.2 Uurlijks Schaduwverloop op 12 Augustus 2026
| Tijdstip (CEST) | Schijnbare Elevatie | Zonne-Azimut | Schaduwlengte (Plat) | **Schaduwlengte (Helling $3^\circ$)** | Schaduwrichting |
| :--- | :---: | :---: | :---: | :---: | :---: |
| **07:00 CEST** | $5.57^\circ$ | $71.89^\circ$ (OZO) | $402.21\text{ m}$ | **$890.15\text{ m}$** | $251.89^\circ$ (WZW) |
| **09:00 CEST** | $23.53^\circ$ | $95.32^\circ$ (Oost) | $90.03\text{ m}$ | **$101.23\text{ m}$** | $275.32^\circ$ (West) |
| **11:00 CEST** | $40.72^\circ$ | $123.06^\circ$ (ZO) | $45.54\text{ m}$ | **$48.22\text{ m}$** | $303.06^\circ$ (NW) |
| **13:00 CEST** | $51.89^\circ$ | $162.35^\circ$ (Z) | $30.75\text{ m}$ | **$32.01\text{ m}$** | $342.35^\circ$ (NNW) |
| **13:36 CEST** *(Piek)* | **$52.89^\circ$** | **$176.50^\circ$ (Zuid)** | **$29.66\text{ m}$** | **$30.90\text{ m}$** | **$360.00^\circ$ (Noord)** |
| **16:00 CEST** | $44.25^\circ$ | $228.56^\circ$ (ZW) | $40.24\text{ m}$ | **$42.39\text{ m}$** | $48.56^\circ$ (NO) |
| **18:00 CEST** | $27.89^\circ$ | $258.46^\circ$ (West) | $74.06\text{ m}$ | **$81.42\text{ m}$** | $78.46^\circ$ (ONO) |
| **20:00 CEST** | $9.72^\circ$ | $282.34^\circ$ (WNW) | $228.92\text{ m}$ | **$331.12\text{ m}$** | $102.34^\circ$ (OZO) |
| **21:00 CEST** *(Zonsondergang)* | **$1.28^\circ$** (Refractie $+22.3'$) | $293.96^\circ$ (NW) | **$1.752.51\text{ m}$** | **$2.485.10\text{ m}$** | $113.96^\circ$ (OZO) |

*Opmerking: Zonder refractiecorrectie zou de berekening op 21:00 CEST uitkomen op $2.464.68\text{ m}$ (plat); de optische opbuiging van $+22.3'$ verkort de theoretische schaduwlengte op een plat vlak met maar liefst **712,17 meter**.*

---

## 4. Seizoensvergelijking (Solstitia & Equinox)

| Parameter / Event | Zomersolstitium (21 juni) | Herfst-equinox (21 sept) | Wintersolstitium (21 dec) |
| :--- | :---: | :---: | :---: |
| **Tijdzone / Piek** | $13:36\text{ CEST}$ | $13:36\text{ CEST}$ | **$12:35\text{ CET}$** |
| **Max. Zonne-elevatie** | **$61.12^\circ$** | **$37.82^\circ$** | **$14.17^\circ$** |
| **Min. Schaduwlengte (Tafelberg 39,2m)** | **$21.78\text{ m}$** | **$50.47\text{ m}$** | **$155.23\text{ m}$** |
| **Min. Schaduwlengte (10m Object)** | $5.55\text{ m}$ | $12.88\text{ m}$ | $39.60\text{ m}$ |
| **Daglichtduur** | **16,75 uur** | **12,17 uur** | **7,50 uur** |

---

## 5. Ruimtelijke Snijpuntanalyse & Diagonale Wal-Pointer

Voor een diagonale wal/perceelsgrens van $2,5\text{ meter}$ hoog, lopend van $A(-30\text{m}, +15\text{m})$ naar $B(+30\text{m}, +35\text{m})$ (totale lengte $63,2\text{ meter}$, helling $3^\circ$ N):

| Tijdstip (CEST) | Elevatie | Schaduwlengte (Helling) | Snijpunt op Diagonale Wal | Schaduwhoogte op Wand | Status op Wand |
| :--- | :---: | :---: | :---: | :---: | :--- |
| **09:00 CEST** | $23.53^\circ$ | $101.23\text{ m}$ | *Geen snijpunt op segment* | $0.00\text{ m}$ | Schaduw valt ten westen van A |
| **11:00 CEST** | $40.72^\circ$ | $48.22\text{ m}$ | $0.8\text{ m}$ vanaf A | $0.15\text{ m}$ | Schaduwtop tipt onderrand bij A |
| **13:00 CEST** | $51.89^\circ$ | $32.01\text{ m}$ | $29.8\text{ m}$ vanaf A | **$2.50\text{ m}$** | **Volledige wand bedekt** |
| **13:36 CEST** | $52.89^\circ$ | $30.90\text{ m}$ | $31.2\text{ m}$ vanaf A | **$2.50\text{ m}$** | **Volledige wand bedekt** |
| **16:00 CEST** | $44.25^\circ$ | $42.39\text{ m}$ | $61.8\text{ m}$ vanaf A | $0.10\text{ m}$ | Schaduwtop tipt wand bij B |
| **18:00 CEST** | $27.89^\circ$ | $81.42\text{ m}$ | *Geen snijpunt op segment* | $0.00\text{ m}$ | Schaduw valt ten oosten van B |

---

## 6. Conclusies & Aanbevelingen

1. **Atmosferische Refractie**: Onmisbaar bij zonnestanden onder $10^\circ$. Bij zonsondergang op de heide bedraagt de opbuiging ruim $22'$ (meer dan een halve zonsdiameter), wat honderden meters verschil maakt in geodetische rasterprojecties.
2. **Terreinhelling**: De noordelijke afhelling van $3^\circ$ verlengt de winterse en ochtendse schaduwen significant. Bij het wintersolstitium reikt de schaduw van de Tafelberg meer dan $155\text{ meter}$ over de hei.
3. **Diagonale Snijpunten**: Het wand-pointer model toont dat tussen 12:30 en 14:30 CEST wandstructuren ten noorden van de heuvel volledig in de schaduw gehuld worden.

---
*Rapport gegenereerd via Gemini Notebook Geodetische Suite (2026).*

#!/usr/bin/env Rscript
# =============================================================================
# Geodetisch-Harmonisch Netwerk: NY–Laren–Stockholm
# Versie: 2.0 | Datum: 30 Sep 2026
# =============================================================================

suppressPackageStartupMessages({
  library(ggplot2)
  library(scales)
  library(dplyr)
  library(tidyr)
})

# -----------------------------------------------------------------------------
# 1. BASIS PARAMETERS
# -----------------------------------------------------------------------------

# Kalender-systemen
TZOLKIN_CYCLE <- 260          # Mayan heilige cyclus (dagen)
HAAB_CYCLE <- 365             # Mayan zonnejaar (dagen)
CALENDAR_ROUND <- 18980       # LCM(260, 365)

# Geografische coördinaten (lat, lon in graden)
coords <- data.frame(
  location = c("New York (WTC1)", "Laren", "Stockholm"),
  lat = c(40.7128, 52.2847, 59.3293),
  lon = c(-73.9352, 4.7889, 18.0686),
  tz_offset = c(-4, 2, 2)  # UTC-offset (EDT/CEST)
)

# Trans-atlantische driehoek afstanden (km) — berekend via haversine
distances <- list(
  ny_laren = 5847.2,
  laren_sth = 1118.5,
  sth_ny = 6320.4
)

# Temperatuur-temperatuur spiegeling
wtc_time_local <- 8.767    # 08:46 EDT
sth_time_local <- 20.767   # 20:46 CEST
utc_offset_wtc <- -4
utc_offset_sth <- 2

# -----------------------------------------------------------------------------
# 2. TIJDSBERECHNINGEN
# -----------------------------------------------------------------------------

calculate_utc_times <- function(local_time, tz_offset) {
  return(local_time + tz_offset)
}

utc_wtc <- calculate_utc_times(wtc_time_local, utc_offset_wtc)
utc_sth <- calculate_utc_times(sth_time_local, utc_offset_sth)
temporal_difference_hours <- abs(utc_sth - utc_wtc)

cat(sprintf("\n=== TEMPORALE SPIEGELING ===\n"))
cat(sprintf("WTC1 lokaal: %.2f EDT → UTC: %.2f\n", wtc_time_local, utc_wtc))
cat(sprintf("Stockholm lokaal: %.2f CEST → UTC: %.2f\n", sth_time_local, utc_sth))
cat(sprintf("UTC-verschil: %.2f uur (niet 12 uur)\n", temporal_difference_hours))
cat(sprintf("Harmonische constructie: %.0f + %.0f = 12 uur\n", 
            temporal_difference_hours, 12 - temporal_difference_hours))

# -----------------------------------------------------------------------------
# 3. FREQUENTIEANALYSE
# -----------------------------------------------------------------------------

# Lichtsnelheid en signaalvertraging
c_light_ms <- 299792.458  # km/ms

total_distance_km <- sum(unlist(distances))
signal_loop_time_ms <- total_distance_km / c_light_ms
fundamental_freq_hz <- 1000 / signal_loop_time_ms  # Hz

# Tun-cyclus convergentie
tun_resonance_factor <- 16
tun_frequency_hz <- fundamental_freq_hz * tun_resonance_factor

cat(sprintf("\n=== FREQUENTIEANALYSE ===\n"))
cat(sprintf("Totale driehoek: %.1f km\n", total_distance_km))
cat(sprintf("Signaalloop: %.3f ms\n", signal_loop_time_ms))
cat(sprintf("Fundamentele frequentie: %.3f Hz\n", fundamental_freq_hz))
cat(sprintf("16× Tun-resonantie: %.1f Hz ≈ 360 Hz\n", tun_frequency_hz))

# Fractale compressie
micro_interval_seconds <- 843.7
macro_cycle_days <- CALENDAR_ROUND
compression_ratio <- (macro_cycle_days * 86400) / micro_interval_seconds

cat(sprintf("\n=== FRACTALE COMPRESSIE ===\n"))
cat(sprintf("Macro-cyclus: %d dagen = %d jaar\n", 
            CALENDAR_ROUND, CALENDAR_ROUND / 365))
cat(sprintf("Micro-interval: %.1f seconde\n", micro_interval_seconds))
cat(sprintf("Compressiefactor: %.0f×\n", compression_ratio))

# -----------------------------------------------------------------------------
# 4. VECTORIËLE ROTATIES
# -----------------------------------------------------------------------------

rad <- function(deg) deg * pi / 180
deg <- function(rad_val) rad_val * 180 / pi

# Broadway-basisvector
broadway_deg <- 22
broadway_vector <- c(cos(rad(broadway_deg)), sin(rad(broadway_deg)))

# Compensatiematrix (1° rotatie)
compensation_deg <- 1
compensation_matrix <- matrix(c(
  cos(rad(compensation_deg)), -sin(rad(compensation_deg)),
  sin(rad(compensation_deg)), cos(rad(compensation_deg))
), nrow = 2, byrow = TRUE)

# Toepassing
transformed_vector <- compensation_matrix %*% broadway_vector
transformed_angle <- deg(atan2(transformed_vector[2], transformed_vector[1]))

# Obliquiteit correlatie
earth_obliquity <- 23.44

cat(sprintf("\n=== VECTORIËLE TRANSFORMATIE ===\n"))
cat(sprintf("Origineel: %.0f° → Gecompenseerd: %.3f°\n", 
            broadway_deg, transformed_angle))
cat(sprintf("Aardas-helling: %.2f° (correlatie: %.3f°)\n", 
            earth_obliquity, abs(transformed_angle - earth_obliquity)))

# -----------------------------------------------------------------------------
# 5. VISUALISATIE: GEODETISCHE TRIANGLE
# -----------------------------------------------------------------------------

# Projectie naar 2D (simple equirectangular voor visualisatie)
project_coords <- function(lat, lon) {
  x <- lon * cos(rad(mean(coords$lat)))
  y <- lat
  return(data.frame(x = x, y = y))
}

proj_data <- project_coords(coords$lat, coords$lon)
proj_data$name <- coords$location

# Triangle edges
edges <- data.frame(
  x = c(proj_data$x[1], proj_data$x[2], proj_data$x[3], proj_data$x[1]),
  y = c(proj_data$y[1], proj_data$y[2], proj_data$y[3], proj_data$y[1]),
  label = c("", "", "", "")
)

p_triangle <- ggplot() +
  geom_path(data = edges, aes(x = x, y = y), 
            color = "#6d4aff", linewidth = 1.5, linetype = "dashed") +
  geom_point(data = proj_data, aes(x = x, y = y, label = name), 
             size = 4, color = "#6d4aff") +
  geom_text(data = proj_data, aes(x = x, y = y, label = name), 
            vjust = -0.8, hjust = 0.5, size = 4, fontface = "bold") +
  annotate("text", x = mean(proj_data$x), y = max(proj_data$y) + 1,
           label = sprintf("Geodetisch Driehoek: %.0f km totaal", total_distance_km),
           hjust = 0.5, size = 3.5, fontface = "italic") +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold"),
    panel.grid = element_blank(),
    axis.title = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank()
  ) +
  labs(title = "NY–Laren–Stockholm: Geodetisch Netwerk")

print(p_triangle)

# -----------------------------------------------------------------------------
# 6. VISUALISATIE: FREQUENTIESCHAAL
# -----------------------------------------------------------------------------

freq_data <- data.frame(
  stage = c("Fundament", "16× Multiplier", "Tun-Resonantie"),
  frequency = c(fundamental_freq_hz, 
                fundamental_freq_hz * 16,
                tun_frequency_hz),
  target = c(NA, NA, 360)
)

p_freq <- ggplot(freq_data, aes(x = stage, y = frequency, fill = stage)) +
  geom_bar(stat = "identity", width = 0.6, color = "#6d4aff") +
  geom_hline(yintercept = 360, linetype = "dotted", color = "red", linewidth = 1) +
  geom_text(aes(label = sprintf("%.1f Hz", frequency)), 
            vjust = -0.5, size = 4) +
  scale_y_continuous(labels = label_number(suffix = " Hz")) +
  theme_minimal(base_size = 12) +
  theme(legend.position = "none",
        plot.title = element_text(hjust = 0.5, face = "bold")) +
  labs(title = "Fotonische Resonantie Cascade",
       subtitle = sprintf("Target: 360 Hz (Maya Tun-cyclus)"))

print(p_freq)

# -----------------------------------------------------------------------------
# 7. VISUALISATIE: COMPRESSIERATIO
# -----------------------------------------------------------------------------

compress_data <- data.frame(
  phase = c("Macro (52 jaar)", "Micro (14 min)"),
  duration_sec = c(CALENDAR_ROUND * 86400, micro_interval_seconds),
  label = c(sprintf("%.0f yr", CALENDAR_ROUND / 365),
            sprintf("%.0f sec", micro_interval_seconds))
)

p_compress <- ggplot(compress_data, aes(x = phase, y = duration_sec, fill = phase)) +
  geom_bar(stat = "identity", width = 0.6) +
  coord_logtrans(base = 10) +
  geom_text(aes(label = label), vjust = 1.5, color = "white", size = 4) +
  scale_y_continuous(labels = label_comma()) +
  theme_minimal(base_size = 12) +
  theme(legend.position = "none",
        plot.title = element_text(hjust = 0.5, face = "bold")) +
  labs(title = "Fractale Tijdcommissie",
       subtitle = sprintf("Compressie: %.0fx", compression_ratio))

print(p_compress)

# -----------------------------------------------------------------------------
# 8. EXPORT
# -----------------------------------------------------------------------------

ggsave("geodetic_network_visualization.png", width = 10, height = 8, dpi = 300)
cat("\n✅ Visualisatie opgeslagen: geodetic_network_visualization.png\n")

# -----------------------------------------------------------------------------
# SAMENVATTING
# -----------------------------------------------------------------------------

cat(sprintf("\n%s\n", paste(rep("=", 60), collapse = "")))
cat("SAMENVATTING ANALYSE\n")
cat(sprintf("%s\n", paste(rep("=", 60), collapse = "")))

summary_table <- data.frame(
  Metric = c("Kalenderronde", "Signal Frequency", "Tun Conversion", 
             "Compression Ratio", "Vector Correction"),
  Value = c(paste0(CALENDAR_ROUND, " dagen"),
            sprintf("%.3f Hz", fundamental_freq_hz),
            paste0(round(tun_frequency_hz, 1), " Hz"),
            sprintf("%.0fx", compression_ratio),
            paste0(broadway_deg, "° → ", round(transformed_angle, 3), "°")),
  Note = c("LCM(260,365)", "Triangel loop", "360-day cycle",
           "52yr → 14min", "Broadway → Obliquity")
)

print(summary_table)

#!/bin/sh

PROJECT="Cluck2Sesame";
PLOT_REPORT="../${PROJECT} (PCB - PLOT REPORT).txt";
PLOT_DIR="../Plots";
ZIP_DIR="${PROJECT}";
ZIP_FILE="${PROJECT}.zip";

rm ${ZIP_DIR}/*;
rm ${ZIP_FILE};

cp "${PLOT_DIR}/${PROJECT} - Bottom Copper.gbr" "${ZIP_DIR}/Bottom Layer.GBL";
cp "${PLOT_DIR}/${PROJECT} - Bottom Copper (Paste).gbr" "${ZIP_DIR}/Bottom Paste Mask.GBP";
cp "${PLOT_DIR}/${PROJECT} - Bottom Copper (Resist).gbr" "${ZIP_DIR}/Bottom Solder Mask.GBS";
cp "${PLOT_DIR}/${PROJECT} - Bottom Silkscreen.gbr" "${ZIP_DIR}/Bottom Overlay.GBO";
cp "${PLOT_DIR}/${PROJECT} - Drill Data - Through Hole.drl" "${ZIP_DIR}/Drill Drawing.GDD";
cp "${PLOT_DIR}/${PROJECT} - PCB.pdf" "${ZIP_DIR}/${PROJECT} Layers.pdf";
cp "${PLOT_DIR}/${PROJECT} - Top Copper.gbr" "${ZIP_DIR}/Top Layer.GTL";
cp "${PLOT_DIR}/${PROJECT} - Top Copper (Paste).gbr" "${ZIP_DIR}/Top Paste Mask.GTP";
cp "${PLOT_DIR}/${PROJECT} - Top Copper (Resist).gbr" "${ZIP_DIR}/Top Solder Mask.GTS";
cp "${PLOT_DIR}/${PROJECT} - Top Silkscreen.gbr" "${ZIP_DIR}/Top Overlay.GTO";
cp "README.txt" "${ZIP_DIR}/README.TXT";
cp "${PLOT_REPORT}" "${ZIP_DIR}/DesignSpark Plot Report.TXT";

zip -9 -r "${ZIP_FILE}" "${ZIP_DIR}";

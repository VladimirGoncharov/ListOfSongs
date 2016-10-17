#!/bin/sh
#  mogend.sh

MACHINE_DIR="${PROJECT_DIR}/ListOfSongs/Models/CoreData/Private"
HUMAN_DIR="${PROJECT_DIR}/ListOfSongs/Models/CoreData"
INCLUDE_H="${PROJECT_DIR}/ListOfSongs/Models/ModelIncludes.h"

echo "machine source path - $MACHINE_DIR/"
echo "human source path - $HUMAN_DIR/"
echo "include.h path - $INCLUDE_H"

mogenerator --model "${INPUT_FILE_PATH}/" --machine-dir "$MACHINE_DIR" --human-dir "$HUMAN_DIR" --includeh "$INCLUDE_H" --template-var arc=true

${DEVELOPER_BIN_DIR}/momc -XD_MOMC_TARGET_VERSION=10.7 "${INPUT_FILE_PATH}" "${TARGET_BUILD_DIR}/${EXECUTABLE_FOLDER_PATH}/${INPUT_FILE_BASE}.momd"

echo "Mogend.sh is done"

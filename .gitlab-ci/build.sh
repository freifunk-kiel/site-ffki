#!/bin/bash -e
# =====================================================================
# Build script for Freifunk Kiel firmware
#
# Source: 
# Contact: 
# Web: 
#
# Credits:
#   - Freifunk Darmstadt for your great support
#   - Freifunk Fulda for the base of the gitlab-ci support
# =====================================================================

# Default make options
MAKEOPTS="-j 4"

# Default to build all Gluon targets if parameter -t is not set
TARGETS="ar71xx-generic ar71xx-tiny ar71xx-nand brcm2708-bcm2708 brcm2708-bcm2709 ramips-mt7621 sunxi x86-generic x86-geode x86-64 ramips-mt7620 ramips-mt7628 ramips-rt305x"
TARGETS=$TARGETS" mpc85xx-generic" # (tp-link-tl-wdr4900-v1)

# BROKEN:
#TARGETS=$TARGETS" ramips-mt76x8" # BROKEN: unstable WiFi (tp-link 841 v13 und archer c50)
#TARGETS=$TARGETS" ar71xx-mikrotik" # BROKEN: no sysupgrade support (mikrotik-nand)
#TARGETS=$TARGETS" brcm2708-bcm2710" # BROKEN: Untested (raspberry-pi-3)
#TARGETS=$TARGETS" ipq806x" # BROKEN: unstable wifi drivers (tp-link-archer-c2600)
#TARGETS=$TARGETS" mvebu-cortexa9" # BROKEN: No AP+IBSS or 11s support (linksys-wrt1200ac)

# Default is set to use current work directory
SITEDIR="$(pwd)"

# Default build identifier set to snapshot
BUILD="snapshot"

# Specify deployment server and user
DEPLOYMENT_SERVER="10.116.250.1"
DEPLOYMENT_USER="rsync"

# Path to signing key
SIGNKEY=""

# Error codes
E_ILLEGAL_ARGS=126

# Help function used in error messages and -h option
usage() {
  echo ""
  echo "Build script for Freifunk-Fulda gluon firmware."
  echo ""
  echo "-b: Firmware branch name (e.g. development)"
  echo "    Default: current git branch"
  echo "-c: Build command: update | clean | download | build | sign | upload | prepare"
  echo "-d: Enable bash debug output"
  echo "-h: Show this help"
  echo "-m: Setting for make options (optional)"
  echo "    Default: \"${MAKEOPTS}\""
  echo "-n: Build identifier (optional)"
  echo "    Default: \"${BUILD}\""
  echo "-t: Gluon targets architectures to build"
  echo "    Default: \"${TARGETS}\""
  echo "-r: Release number (optional)"
  echo "    Default: fetched from release file"
  echo "-w: Path to site directory"
  echo "    Default: current working directory"
  echo "-s: Path to signing key"
  echo "    Default: empty"
}

# Evaluate arguments for build script.
if [[ "${#}" == 0 ]]; then
  usage
  exit ${E_ILLEGAL_ARGS}
fi

# Evaluate arguments for build script.
while getopts b:c:dhm:n:t:w:s: flag; do
  case ${flag} in
    b)
        BRANCH="${OPTARG}"
        ;;
    c)
      case "${OPTARG}" in
        update)
          COMMAND="${OPTARG}"
          ;;
        clean)
          COMMAND="${OPTARG}"
          ;;
        download)
          COMMAND="${OPTARG}"
          ;;
        build)
          COMMAND="${OPTARG}"
          ;;
        sign)
          COMMAND="${OPTARG}"
          ;;
        upload)
          COMMAND="${OPTARG}"
          ;;
        prepare)
          COMMAND="${OPTARG}"
          ;;
        *)
          echo "Error: Invalid build command set."
          usage
          exit ${E_ILLEGAL_ARGS}
          ;;
      esac
      ;;
    d)
      set -x
      ;;
    h)
      usage
      exit
      ;;
    m)
      MAKEOPTS="${OPTARG}"
      ;;
    n)
      BUILD="${OPTARG}"
      ;;
    t)
      TARGETS="${OPTARG}"
      ;;
    r)
      RELEASE="${OPTARG}"
      ;;
    w)
      # Use the root project as site-config for make commands below
      SITEDIR="${OPTARG}"
      ;;
    s)
      SIGNKEY="${OPTARG}"
      ;;
    *)
      usage
      exit ${E_ILLEGAL_ARGS}
      ;;
  esac
done

# Strip of all remaining arguments
shift $((OPTIND - 1));

# Check if there are remaining arguments
if [[ "${#}" > 0 ]]; then
  echo "Error: To many arguments: ${*}"
  usage
  exit ${E_ILLEGAL_ARGS}
fi

# Set command
if [[ -z "${COMMAND}" ]]; then
  echo "Error: Build command missing."
  usage
  exit ${E_ILLEGAL_ARGS}
fi

# Set release number
if [[ -z "${RELEASE}" ]]; then
  RELEASE=$(cat "${SITEDIR}/release")
fi

# Get the GIT commit description
COMMIT="$(git describe --always --dirty)"

# Name of the autoupdater branch that is selected on the node: 'rc', 'nightly', 'next' or 'stable'
BRANCH="stable"

# key of the autoupdater branch for the name and BRANCH of the 2nd manifest: 'rc', 'nightly', 'next' or 'stable'
AU_BRANCH_2="rc"

# Determine upload target prefix: 'release-candidate', 'nightly' or 'next'
TARGET_DIR="release-candidate"

# Number of days that may pass between releasing an updating
PRIORITY=1

update() {
  echo "--- Update Gluon Dependencies"
  make ${MAKEOPTS} \
       GLUON_SITEDIR="${SITEDIR}" \
       GLUON_OUTPUTDIR="${SITEDIR}/output" \
       GLUON_RELEASE="${RELEASE}-${BUILD}" \
       GLUON_BRANCH="${BRANCH}" \
       GLUON_PRIORITY="${PRIORITY}" \
       update
}

clean() {
  for TARGET in ${TARGETS}; do
    echo "--- Clean Gluon Build Artifacts for target: ${TARGET}"
    make ${MAKEOPTS} \
         GLUON_SITEDIR="${SITEDIR}" \
         GLUON_OUTPUTDIR="${SITEDIR}/output" \
         GLUON_RELEASE="${RELEASE}-${BUILD}" \
         GLUON_BRANCH="${BRANCH}" \
         GLUON_PRIORITY="${PRIORITY}" \
         GLUON_TARGET="${TARGET}" \
         clean
  done
}

download() {
  for TARGET in ${TARGETS}; do
    echo "--- Download Gluon Dependencies for target: ${TARGET}"
    make ${MAKEOPTS} \
         GLUON_SITEDIR="${SITEDIR}" \
         GLUON_OUTPUTDIR="${SITEDIR}/output" \
         GLUON_RELEASE="${RELEASE}-${BUILD}" \
         GLUON_BRANCH="${BRANCH}" \
         GLUON_PRIORITY="${PRIORITY}" \
         GLUON_TARGET="${TARGET}" \
         download
  done
}

build() {
  for TARGET in ${TARGETS}; do
    echo "--- Build Gluon Images for target: ${TARGET}"
    case "${BRANCH}" in
      stable)
        make ${MAKEOPTS} \
             GLUON_SITEDIR="${SITEDIR}" \
             GLUON_OUTPUTDIR="${SITEDIR}/output" \
             GLUON_RELEASE="${RELEASE}-${BUILD}" \
             GLUON_BRANCH="${BRANCH}" \
             GLUON_PRIORITY="${PRIORITY}" \
             GLUON_TARGET="${TARGET}"
        ;;

      *)
        make ${MAKEOPTS} \
             GLUON_SITEDIR="${SITEDIR}" \
             GLUON_OUTPUTDIR="${SITEDIR}/output" \
             GLUON_RELEASE="${RELEASE}-${BUILD}" \
             GLUON_BRANCH="${BRANCH}" \
             GLUON_TARGET="${TARGET}"
      ;;
    esac
  done

  echo "--- Build Gluon Manifest"
  make ${MAKEOPTS} \
       GLUON_SITEDIR="${SITEDIR}" \
       GLUON_OUTPUTDIR="${SITEDIR}/output" \
       GLUON_RELEASE="${RELEASE}-${BUILD}" \
       GLUON_BRANCH="${BRANCH}" \
       GLUON_PRIORITY="${PRIORITY}" \
       manifest

  echo "--- Write Build file"
  cat > "${SITEDIR}/output/images/build" <<EOF
DATE=$(date '+%Y-%m-%d %H:%M:%S')
VERSION=$(cat "${SITEDIR}/release")
RELEASE=${RELEASE}
BUILD=${BUILD}
BRANCH=${BRANCH}
COMMIT=${COMMIT}
HOST=$(uname -n)
EOF
}

sign() {
  echo "--- Sign Gluon Firmware Build"
  
  MANIFEST="${SITEDIR}/output/images/sysupgrade/${BRANCH}.manifest"
  MANIFEST_2="${SITEDIR}/output/images/sysupgrade/${AU_BRANCH_2}.manifest"
  
  # keep the clean manifest for later signing of NOC members and for the BRANCH file
  cp -a "${MANIFEST}" "${MANIFEST}.clean"

  # create clean 2nd manifest with AU_BRANCH_2 as BRANCH
  cp -a "${MANIFEST}.clean" "${MANIFEST_2}.clean"
  sed -i 's/BRANCH='"${BRANCH}"'/BRANCH='"${AU_BRANCH_2}"'/g' "${MANIFEST_2}.clean"
  
  # Add the signature to the manifest file
  contrib/sign.sh \
      "${SIGNKEY}" \
      "${MANIFEST}"

  # Add the signature to the the 2nd manifest file
  cp -a "${MANIFEST_2}.clean" "${MANIFEST_2}"
  contrib/sign.sh \
      "${SIGNKEY}" \
      "${MANIFEST_2}"
}

upload() {
  echo "--- Upload Gluon Firmware Images and Manifest"

  # Build the ssh command to use
  SSH="ssh"
  SSH="${SSH} -o stricthostkeychecking=no -v"

  # Create the target directory on server
  ${SSH} \
      ${DEPLOYMENT_USER}@${DEPLOYMENT_SERVER} \
      -- \
      mkdir \
          --parents \
          --verbose \
          "/opt/firmware/ffki/${TARGET_DIR}/${RELEASE}-${BUILD}"

  # Add site metadata
  tar -czf "${SITEDIR}/output/images/site.tgz" --exclude='gluon' --exclude='output' "${SITEDIR}"

  # Copy images to server
  rsync \
      --verbose \
      --recursive \
      --compress \
      --progress \
      --links \
      --chmod=ugo=rwX \
      --rsh="${SSH}" \
      "${SITEDIR}/output/images/" \
      "${DEPLOYMENT_USER}@${DEPLOYMENT_SERVER}:/opt/firmware/ffki/${TARGET_DIR}/${RELEASE}-${BUILD}"
  ${SSH} \
      ${DEPLOYMENT_USER}@${DEPLOYMENT_SERVER} \
      -- \
      ln -sf \
          "/opt/firmware/ffki/${TARGET_DIR}/${RELEASE}-${BUILD}/sysupgrade" \
          "/opt/firmware/ffki/${TARGET_DIR}/"
  ${SSH} \
      ${DEPLOYMENT_USER}@${DEPLOYMENT_SERVER} \
      -- \
      ln -sf \
          "/opt/firmware/ffki/${TARGET_DIR}/${RELEASE}-${BUILD}/factory" \
          "/opt/firmware/ffki/${TARGET_DIR}/"
}

prepare() {
  echo "--- Prepare directory for upload"

  # Create the target directory on server
  mkdir \
    --parents \
    --verbose \
    "${SITEDIR}/output/firmware/${TARGET_DIR}"

  # Copy images to directory
  mv \
    --verbose \
    "${SITEDIR}/output/images" \
    "${SITEDIR}/output/firmware/${TARGET_DIR}/${RELEASE}-${BUILD}"

  # Link latest upload in target directory to 'current'
  cd "${SITEDIR}/output"
  ln \
      --symbolic \
      --force \
      --no-target-directory \
      "${RELEASE}-${BUILD}" \
      "firmware/${TARGET_DIR}/current"
}

(
  # Change working directory to gluon tree
  cd "${SITEDIR}/gluon"

  # Execute the selected command
  ${COMMAND}
)

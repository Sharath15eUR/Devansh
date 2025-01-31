#!/bin/bash


INPUT_FILE="input.txt"
OUTPUT_FILE="output.txt"

if [[ ! -f "$INPUT_FILE" ]]; then
    echo "Error: Input File '$INPUT_FILE' is not found."
    exit 1
fi

> "$OUTPUT_FILE"


awk -F': ' '
{
    if ($1 ~ /frame.time/) frame_time = $2;
    if ($1 ~ /wlan.fc.type/) wlan_fc_type = $2;
    if ($1 ~ /wlan.fc.subtype/) wlan_fc_subtype = $2;

    if (frame_time && wlan_fc_type && wlan_fc_subtype) {
        print "\"frame.time\": \"" frame_time "\",\"wlan.fc.type\": \"" wlan_fc_type "\",\"wlan.fc.subtype\": \"" wlan_fc_subtype "\"" >> "'"$OUTPUT_FILE"'";
        frame_time = wlan_fc_type = wlan_fc_subtype = "";
    }
}
' "$INPUT_FILE"


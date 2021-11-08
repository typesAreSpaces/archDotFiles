current_dir="/home/jose/.config/zathura"
pushd "$current_dir"
rm -rf zathurarc
touch zathurarc
cat zathurarc-init-block >> zathurarc
cat zathurarc-tokyo >> zathurarc
popd

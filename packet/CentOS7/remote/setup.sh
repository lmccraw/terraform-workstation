

# Base Yum Operations
yum update -y
yum -y install epel-release
declare -a yumlist1=(kernel-devel kernel-headers gcc dkms make libgomp patch binutils glibc-headers glibc-devel font-forge jq mlocate unzip)
yum install -y ${yumlist1[@]}
updatedb

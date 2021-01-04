
```shell
>：              执行结果重定向到指定位置，将本应显示在终端的内容保存到指定文件中
		   cat fileName > text（text不存在则创建，存在覆盖其内容）
		   ls -ahl >> text（不论text存不存在，都将内容写进text最后
*：              适配符，适配任意长度字符，可以为空
?：              适配符，适配一个字符，不能为空
[requre] --help：显示该命令的所有可扩展操作
man [section] requre：通过文档形式显示有关此命令的指南，可以选择章节
history：        显示操作历史记录
 | ：            链接两个命令，常用于通过后命令拓展前命令
which requre：   显示命令的路径
ps [commond]：   显示进程
           ps -a:显示终端所有进程，包括所有用户的
           ps -u:显示进程的详细状态
           ps -x:显示没有控制终端的进程
           ps -w:显示加宽，以便显示更多信息
           ps -r:只显示正在运行的进程
top：            动态的显示进程
ssh userName@ipdress：远程通过userName登录ipdress的电脑
who：            查看当前登录的所有用户信息
whoami：         显示当前终端的用户名
exit：           注销
useradd userName [commond]：添加新用户
           useradd userName -d /path:指定用户的home目录
           useradd userName -g:指定组名称
           useradd userName -m:如果home目录不存在则自动创建该目录
passwd userName：修改密码
su userName：    切换用户
sudo -s：        切换超级用户
userdel -r userName：删除用户。不加-r不会删除该用户的主目录
groupmod + 多次TAB键：显示所有用户组
groupadd：       添加用户组
groupdel：       删除用户组
groups userName：查看用户所在组
usermod [commond] groupName userName：用户组
           usermod -g groupName userName：切换用户所在主要用户组
           usermod -aG groupName userName：给用户添加用户组
chmod [commond] fileName：修改权限
           chmod 777 fileName -R:修改该文件夹下所有文件的权限为777
     文字法：chmod [u/g/o/a] [+/-/=] [r/w/x] fileName
           [u/g/o/a]:[所有者/所有者所在组/其它/所有人]
           [+/-/=]:[增加权限/删除权限/设定权限]
           [r/w/x]:[读/写/执行]
     数字法：chmod [limet] fileName
           [limet]:三位(u/g/o)，每位数字是其权限的和
           [r/w/x]:[4/2/1]
chown fileName：修改文件所有者
chgrp fileName：修改文件所属组
cal：            日历
date：           显示时间
reboot：         重启
shutdown [commond] [time]：重启或关机
           shutdown -r now:重启，并给出提示
           shutdown -h now:立刻关机
           shutdown -h 20:24:在20:24时关机
           shutdown -h +10:十分钟后关机
init [number]：  重启或关机
           init 0:关机
           init 6:重启
df [commond]：   检查磁盘空间
           df -a:显示所有文件系统的磁盘使用情况
           df -m:以1024字节为单位显示
           df -t:显示各指定文件系统的磁盘空间使用情况
           df -T:显示文件系统
du [commond] fileName：检测文件夹所占磁盘空间
           du -a:递归显示文件夹占用的数据块
           du -s:显示指定目录占用的数据块
           du -h:以合适的单位显示占用情况
           du -I:计算所有文件大小
ls [commond]：   显示该文件夹的所有文件和文件夹名称
           ls -h:必须何其它commond符号连用，适配合适的单位
           ls -a:显示所有数据，包括隐藏
           ls -l:显示操作权限、文件名个数、修改人、所有人、占用空间、创建时间、文件名，不包括隐藏
more fileName：  显示文件内的内容，每次只显示一页，space切下一页，q退出显示，h显示帮助
cat fileName：   完全显示文件内的内容
cp oldFile newFile：复制文件
           cp oldFile newFile -a:通常在复制文件夹时使用，保留原文件的所有属性、结构
           cp oldFile newFile -f:若newFile重名则依然复制不提示
           cp oldFile newFile -i:复制时给出确认的选项
           cp oldFile newFile -r:复制文件夹必须使用。递归的复制文件夹内的所有子文件，newFile必须为一个文件夹
           cp oldFile newFile -v:显示拷贝进度
mv fileName [/path,newName]：移动或重命名文件、文件夹
           mv fileName /path -f:忽略错误强制
           mv fileName /path -i:移动或重命名时给出确认的选项
           mv fileName /path -v:显示移动进度
cd /path：       cd -:载入上次所在目录，再次命令则跳回
           cd ~:跳转到当前用户的/home目录
pwd：            显示当前路径
mkdir fileName：          创建文件夹
           mkdir a/b/c -p:创建文件夹树
touch fileName： 创建文件
mv fileName <choseOptions>：
           mv file file.txt:将file重命名为file.txt
           mv file /etc/fonts/:将file移动到/etc/fonts/    
rm fileName [commond]：删除文件、文件夹
           rm file -i:会询问是否删除
           rm file -f:强制删除，忽略不存在的文件，无需提示
           rm file -r:删除文件夹时必加，递归地删除
rmdir fileName： 删除文件夹，且文件夹必须为空，不然提示删除失败
tree：           显示当前文件夹的树形结构
ln [commond] sourceFile newFile：链接文件类似于创建快捷方式
           ln soureFile newFile:代表硬链接，两个文件占用相同大小的空间，只能链接普通文件，无法链接文件夹。且删除源文件链接依然存在
           ln -s soureceFile newFile:代表软链接，不占用磁盘空间，源文件删除则链接失效
find /path [commond] fileName：在/path下查找指定的文件
           find /path -name fileName:通过名字查找文件
           find /path -size +(-)size:通过大小来找文件，可以指定范围（大于+，小于-，也可以同时指定上下限）
           find /path -perm 0777:通过权限等级来查找权限
tar [commond] fileName：归档或解档文件
           tar -c fileName:归档文件
           tar -x fileName:解档文件
           tar -v fileName:显示进度
           tar -t fileName:列出档案包含的文件
           tar -f .tarFile fileName:指定档案文件名称，f后必须是.tar文件。有多个指令时，f指令顺序放在最后
           tar -z .tar.gzFile fileName:打包并压缩(后跟-c指令)或解压并解档(后跟-x指令)
           tar -j .tar.bz2File fileName:使用bz2类型压缩或解压
           tar fileName -C /path:归档或解档到指定路径
gzip [commond] fileName：压缩或解压文件
           gzip -d fileName:解压文件
           gzip -r fileName:压缩文件
zip (-r) toFile fileName：压缩fileName为toFile.zip
unzip -d toFile fileName：解压fileName.zip到toFile
grep [commond] ‘string’ fileName：在对应文件内搜索包含string字词的行，string可以是正则表达式
           grep -v 'string' fileName:显示不包含匹配到的行
           grep -n 'string' fileName:显示匹配行及行号
           grep -i 'string' fileName:忽略大小写
```

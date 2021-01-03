
# HowToInvokeVboxInBootWin
VirtualBoxをWindowsサービスを使ってWindowsブート時にheadlessモードで起動する方法について述べる。

次の手順で作成する。

 1. Guest Linux Imageの作成
 2. Vboxのコンフィグレーション
 3. Sambaの自動マウントバッチファイル作成

## 1. Guest Linux Image作成
Vboxをインストールした環境でUbuntuのGuest Imageを作成する。Ubuntuは18.04 LTSを用いる。[このISO](http://cdimage.ubuntulinux.jp/releases/18.04.3/ubuntu-ja-18.04.3-desktop-amd64.iso) をダウンロードしてインストールすれば良い。  
HDD容量は、最低で10GB必要だが、推奨は20GBである。インストールした後、下記のコンフィグを行う。

## 2. Vboxのコンフィグレーション
ターゲットとなるWindowsホストにVirtualBoxをインストールしてコンフィグする。これ以降の記述は現時点での最新バージョンである 6.1.16 を対象とする。コンフィグの目的は、Windowsサービスを用いてWindows起動時に対象のVMをheadlessで起動することである。
### 2-1. Vboxイメージとコンフィグの配置
複数のユーザーに拡張可能とするために、個人フォルダではなく、共通領域に配置する。例えば、`C:\VboxAutoStart` というディレクトリを作成して、ここを起点に配置する。以降、仮想マシンの名称を`ubuntu18` と仮定する。
### 2-2. パスの追加
`C:\Program Files\Oracle\VirtualBox`を環境変数のパスに追加する。
### 2-3. 自動起動を可能にするための設定
コマンドプロンプトで以下の設定を行う。
#### ubuntu18を自動起動対象仮想マシンに設定する
```
> VboxManage modifyvm ubuntu18 --autostart-enabled on
```
#### 自動起動を用いるユーザーにサービスをインストールする
``` 
> VBoxAutostartSvc install --user=<user>
```
上記実行時にuserのパスワード問い合わせがあるので適宜入力すること。
#### 自動起動コンフィグファイルの作成と環境変数設定
このリポジトリに格納した、AutoStartConfig.txtを`C:\VboxAutoStart` 直下にコピーする。（全てのユーザーが自動起動設定可能となる条件となっているため、特殊な事情がなければこのファイルをそのまま用いて良い。）このファイルへのパスを環境変数`VBOXAUTOSTART_CONFIG` に設定する。


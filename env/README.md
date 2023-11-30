

## `build.sh`
```
bck_img/${image_name}_$(date '+%Y%m%d').tar
```
ビルドしたDockerイメージをtar形式で保存。ファイル名には現在の日付が含まれる

### 活用の仕方
イメージのロード
```
docker load -i "bck_img/${image_name}_$(date '+%Y%m%d').tar"
```
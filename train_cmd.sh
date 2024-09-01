yaml_list="DLA34 DLA34_star DLA34_faster"

lr_list="0.05 0.08 0.1 0.2 0.4 0.6 0.8"

config_dir="ppcls/configs/ImageNet/DLA"
base_cmd="python -u -m paddle.distributed.launch --gpus='0,1,2,3,4,5,6,7' tools/train.py -c"

rm -rf run_list.txt

for yaml_name in $yaml_list; do
    yaml_file="$config_dir/$yaml_name.yaml"
    for lr in $lr_list; do
        output_dir="output/${yaml_name}_lr${lr}"
        cmd="$base_cmd $yaml_file -o Optimizer.lr.learning_rate=$lr -o Global.output_dir=$output_dir -o Global.epochs=12"
        echo $cmd >> run_list.txt
    done
done
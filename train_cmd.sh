yaml_list="DLA34_multi"

blocks="dfss fsss"


config_dir="ppcls/configs/ImageNet/DLA"
base_cmd="python -u -m paddle.distributed.launch --gpus='0,1,2,3,4,5,6,7' tools/train.py -c"

rm -rf run_list.txt

for yaml_name in $yaml_list; do
    yaml_file="$config_dir/$yaml_name.yaml"
    for blk in $blocks; do
        output_dir="output/${yaml_name}_lr0.1_${blk}"
        cmd="$base_cmd $yaml_file -o Optimizer.lr.learning_rate=0.1 -o Global.output_dir=$output_dir -o Global.epochs=10 -o Arch.blocks=$blk"
        echo $cmd >> run_list.txt
    done
done
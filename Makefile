default:_build _run

_build:
	docker build -t diffuscene .

_run: $(ARGS)
_run: ARGS += --rm
_run: ARGS += -it
_run: ARGS += --gpus all
_run:
	if [ -d "dataset/3dfront" ]; then \
# todo \
#		ARGS += -v $(pwd)/dataset/3dfront:... \
		echo 'not implemented';\
	fi

	-docker run ${ARGS} diffuscene


dataset/3dfront:
	echo 'not implemented'
	exit 1
#todo
#	mkdir -p dataset/3dfront

dataset/3dfuture:
	echo 'not implemented'
	exit 1
#todo
#	mkdir -p dataset/3dfuture

_dataset: dataset/3dfront dataset/3dfuture
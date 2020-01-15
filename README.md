# SLUMPs 
*Research on randomization and superoptimization for WebAssembly WASM*


Given a C program, SLUMPs repurposes a superoptimizer(Souper) to provide several WASM programs as output. This tool uses Souper, first, we search for optimizations candidates. Each resulting programs correspond to a subset of applied optimizations (extracted from the previous mentioned step).

### Prerequisites

- You need to download our changed version of Souper. The main reason behind is that we include some extra options to be able of working together with the SLUMPs core. After downloading all the submodules in SLUMPs, build every one of them following the respective instructions.
- Build wabt toolkit to provide the WASM to WAT conversion for debugging reasons
- Install the python requirements: ```pip3 install -r src/requirements.txt```

### Troubleshooting

- **SLUMPs shows a fail in the CLANG step**: Install emscripten and run it as follows ```emcc -v <file>.c```. Then copy all the include flies in the [include](https://github.com/KTH/slumps/blob/18ef5189904e25019155fe305046f4b5b8907538/src/settings/config.ini#L17) configuration for SLUMPs.
- **SLUMPs shows a fail connecting to REDIS**: Install Redis in your local pc and ensure that its running, or change the usage of external cache in the Souper [config](https://github.com/KTH/slumps/blob/18ef5189904e25019155fe305046f4b5b8907538/src/settings/config.ini#L58).
- **SLUMPs doesn't find the souper folder**: Check the [path](https://github.com/KTH/slumps/blob/18ef5189904e25019155fe305046f4b5b8907538/src/settings/config.ini#L2) in the settings file
- **SLUMPs fails in the souper opt pass**: Check the [name](https://github.com/KTH/slumps/blob/18ef5189904e25019155fe305046f4b5b8907538/src/settings/config.ini#L48) for the souper pass (for instance, the extension for Ubuntu can be different to the Mac one).

### Config options

- **Optimization subset strategy**: [generator-method](https://github.com/KTH/slumps/blob/18ef5189904e25019155fe305046f4b5b8907538/src/settings/config.ini#L9) = subset | onexone | all

- **Output only different binaryes**: [prune-equal](https://github.com/KTH/slumps/blob/18ef5189904e25019155fe305046f4b5b8907538/src/settings/config.ini#L6), we calculate the sha256 value for evey WASM program, then we keep only the programs with different sha values.

Change the remaining values to get different results, for instance, add extra arguments to the CLANG step.

### How to use it

Run ```python3  src/slumps.py <file.c>``` or run it directly to LLVM (it needs to be thought for the 'wasm32-unknown-unknown' target) ```python3 src/slumps.py <file.ll>```

## Docker images

To run slumps in an easy way. We provide a docker image to be used as the parent for SLUMPs. The parent image contains the plumping to work with souper (our modest changed version), binaryen and wabt


### To build docker images
- ```docker build -t slumps:backend -m 8g -f docker_images/Dockerfile .```


#### Troubleshooting
- LLVM build takes to long or fails due to memory lack in the image building:
    >  Increase memory and/or CPU ressources in the docker engine configuration


### Develop mode

- Go to python folder in the repo 
- ```docker run --rm -it -v $(pwd):/slumps/src -v <absolute_path>/slumps/src:/input --entrypoint /bin/bash slumps:<label>```


## Study of memory disclosure vulnerabilities

[Slides](https://jacarte.github.io/wasm_presentation/)



## Souper new features

We add some features/options to Souper. The included features are listed below

- **souper-subset**: Specify the candidates to be applied, for example
```-souper-subset=1,2,3,4``` or ```-souper-subset=0,3```


- **souper-valid-count**: Search for optimizations without replacing

- **souper-redis-host**: Host for redis
- **souper-redis-pass**: Password for redis connection


## Issues

- Candidates overlapping

Example for bitwise_IO problem

```Total number of programs 2048. Different sha count 36. Prunned count 2012 ```

Only 36 different programs

- LLVM frontend for WASM:

This will provide the WASM -> WASM behavior in SLUMPs
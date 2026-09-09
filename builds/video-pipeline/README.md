# The Production Line

This is a content production line. It makes 1 video at a time. Each run starts
at a locked keyword and ends with a published video, its package and its blog
post. An AI follows the written steps. Scripts stop a bad video before you record it. You approve at every
stage. Built by RyMac, and it has shipped 40+ videos.

## Start a run

1. Read `00-START-HERE.md`. It is written for you and takes a few minutes.
2. Open your AI in this folder and paste prompt 1 from `PROMPTS.md`. It
   interviews you and writes your answers into `_config/my-line.md`.
3. Paste prompt 2 with your first topic. The line runs from `01_gameplan/`.
4. At every stage you read 1 file and approve it. Nothing moves before you do.

## What you need

This folder, and an AI assistant that reads files and follows skills. It must
be able to run the scripts in `checks/` and `skills/`. Cloud rendering is set up
once, before the first video: `_reference/cloud-rendering.md`.

## Credit

This workspace is built on Interpretable Context Methodology (ICM). The method
was created by Jake Van Clief and David McDermott. It is MIT-licensed, and the
paper is here: https://arxiv.org/abs/2603.16021

The folders do the work a framework would do in code. Numbered folders carry
the order. Each folder's own file says what to read. Plain text files carry
the state. 1 agent walks the folders in order.

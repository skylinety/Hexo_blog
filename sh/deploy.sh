#!/bin/bash

# auto deploy
rm -rf ~/workSpace/skyline-blog-hexo/blog/md_backs/*
hexo clean
hexo g
hexo d
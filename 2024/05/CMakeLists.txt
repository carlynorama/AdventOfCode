cmake_minimum_required(VERSION 3.29)
set(PROJECT_NAME $ENV{PN})
set(MAIN_TARGET_NAME ${PROJECT_NAME})
set(sharedFilesDir $ENV{SHARED})

project(${PROJECT_NAME} LANGUAGES Swift)

add_executable(${MAIN_TARGET_NAME} 
    main.swift
    testData.swift
    $ENV{DATA_FOLDER}/realData.swift
)
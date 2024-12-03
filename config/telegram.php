<?php

return [
    // 机器人设置
    'botConfig' => [
        'bots' => [
            'randallanjie_bot' => [
                'token' => env('TG_BOT_TOKEN', 'notgbot'),
            ],
        ]
    ],
    // 管理员设置
    'adminId' => env('TG_BOT_ADMIN_ID', ''),
    // 群组设置
    'groupSetting' => [
        // 群组ID
        'chat_id' => env('TG_BOT_GROUP_ID', ''),
        // 是否允许通知
        'allow_notify' => env('TG_BOT_GROUP_NOTIFY', false),
    ]
];

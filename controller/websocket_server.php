<?php
use Ratchet\MessageComponentInterface;
use Ratchet\ConnectionInterface;
use React\EventLoop\Factory;
use React\Socket\Server as ReactSocketServer;
use Ratchet\Http\HttpServer;
use Ratchet\WebSocket\WsServer;
use Ratchet\Server\IoServer;

require dirname(__DIR__) . '/vendor/autoload.php';

// Tạo class WebSocketServer
class WebSocketServer implements MessageComponentInterface {
    protected $clients;

    public function __construct() {
        $this->clients = new \SplObjectStorage;
    }

    public function onOpen(ConnectionInterface $conn) {
        // Lưu kết nối của client khi có kết nối mới
        $this->clients->attach($conn);
        echo "một kết nối mới ({$conn->resourceId})\n";
    }

    public function onMessage(ConnectionInterface $from, $msg) {
        // Xử lý tin nhắn từ client và gửi lại cho tất cả client khác
        foreach ($this->clients as $client) {
            if ($client !== $from) {
                $client->send($msg);
            }
        }
    }

    public function onClose(ConnectionInterface $conn) {
        // Xóa kết nối khi client đóng kết nối
        $this->clients->detach($conn);
        echo "người dùng {$conn->resourceId} không còn kết nối\n";
    }

    public function onError(ConnectionInterface $conn, \Exception $e) {
        // Xử lý lỗi khi có lỗi xảy ra trên kết nối
        echo "đã có lỗi: {$e->getMessage()}\n";
        $conn->close();
    }
}

// Tạo EventLoop của ReactPHP
$loop = Factory::create();

// Tạo một server socket bằng ReactPHP
$socket = new ReactSocketServer('127.0.0.1:8000', $loop);
// $socket = new ReactSocketServer('web2.orggenji.click', $loop);

// Tạo server WebSocket bằng Ratchet
$server = new IoServer(
    new HttpServer(
        new WsServer(
            new WebSocketServer()
        )
    ),
    $socket,
    $loop
);

echo "WebSocket server is running...\n";

$server->run();

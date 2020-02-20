<?php
use PHPUnit\Framework\TestCase;

require __DIR__ . '/../src/App.php';

class AppTest extends TestCase
{
    public function testContentsOfIndex()
    {
	$app = new App();
        $this->assertEquals('Hello world!', $app->index());
    }
}

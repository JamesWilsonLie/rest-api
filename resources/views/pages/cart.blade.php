@extends('layouts.app-public')
@section('title', 'Cart')
@section('content')

<div class="site-wrapper-reveal">
    <div class="section-space--pb_120">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <h2>Cart</h2>
                    <table id="cart-table" class="table">
                        <thead>
                            <tr>
                                <th>No</th>
                                <th>Name</th>
                                <th>Image</th>
                                <th>Type</th>
                                <th>Carat</th>
                                <th>Price</th>
                                <th>Subtotal</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- cart items will be rendered here -->
                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="6">Total:</td>
                                <td id="total-price">$0.00</td>
                            </tr>
                        </tfoot>
                    </table>
                    <button id="checkout-btn" class="btn btn-primary">Checkout</button>
                </div>
            </div>
        </div>
    </div>
</div>

@endsection
@section('addition_css')
@endsection
@section('addition_script')
@endsection
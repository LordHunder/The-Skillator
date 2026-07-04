# Best Practices & Common Pitfalls

## Best Practices Checklist

- [ ] **Fail Fast** — Validate input early, fail quickly
- [ ] **Preserve Context** — Include stack traces, metadata, timestamps
- [ ] **Meaningful Messages** — Explain what happened and how to fix it
- [ ] **Log Appropriately** — Error = log, expected failure = don't spam logs
- [ ] **Handle at Right Level** — Catch where you can meaningfully handle
- [ ] **Clean Up Resources** — Use try-finally, context managers, defer
- [ ] **Don't Swallow Errors** — Log or re-throw, don't silently ignore
- [ ] **Type-Safe Errors** — Use typed errors when possible

## Complete Example

```python
def process_order(order_id: str) -> Order:
    """Process order with comprehensive error handling."""
    try:
        # Validate input
        if not order_id:
            raise ValidationError("Order ID is required")

        # Fetch order
        order = db.get_order(order_id)
        if not order:
            raise NotFoundError("Order", order_id)

        # Process payment
        try:
            payment_result = payment_service.charge(order.total)
        except PaymentServiceError as e:
            # Log and wrap external service error
            logger.error(f"Payment failed for order {order_id}: {e}")
            raise ExternalServiceError(
                f"Payment processing failed",
                service="payment_service",
                details={"order_id": order_id, "amount": order.total}
            ) from e

        # Update order
        order.status = "completed"
        order.payment_id = payment_result.id
        db.save(order)

        return order

    except ApplicationError:
        # Re-raise known application errors
        raise
    except Exception as e:
        # Log unexpected errors
        logger.exception(f"Unexpected error processing order {order_id}")
        raise ApplicationError(
            "Order processing failed",
            code="INTERNAL_ERROR"
        ) from e
```

## Common Pitfalls

| Pitfall | Why It's Bad | Fix |
|---------|-------------|-----|
| **Catching Too Broadly** | `except Exception` hides bugs | Catch specific error types |
| **Empty Catch Blocks** | Silently swallowing errors | Always log or re-throw |
| **Logging and Re-throwing** | Creates duplicate log entries | Log at one level only |
| **Not Cleaning Up** | Forgetting to close files, connections | Use context managers / defer / finally |
| **Poor Error Messages** | "Error occurred" is not helpful | Include what, why, and how to fix |
| **Returning Error Codes** | Easy to ignore return values | Use exceptions or Result types |
| **Ignoring Async Errors** | Unhandled promise rejections crash apps | Always `.catch()` or try/await |
